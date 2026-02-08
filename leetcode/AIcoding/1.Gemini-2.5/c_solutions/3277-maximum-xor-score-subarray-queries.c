#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define MAX_BITS 30

typedef struct TrieNode {
    int children[2];
} TrieNode;

TrieNode* trie_nodes;
int trie_node_count;

int new_trie_node() {
    trie_nodes[trie_node_count].children[0] = 0;
    trie_nodes[trie_node_count].children[1] = 0;
    return trie_node_count++;
}

void insert_into_trie(int root_idx, int val) {
    int curr = root_idx;
    for (int i = MAX_BITS - 1; i >= 0; i--) {
        int bit = (val >> i) & 1;
        if (trie_nodes[curr].children[bit] == 0) {
            trie_nodes[curr].children[bit] = new_trie_node();
        }
        curr = trie_nodes[curr].children[bit];
    }
}

int query_max_xor(int root_idx, int val) {
    if (root_idx == 0) return 0;
    int curr = root_idx;
    int max_xor_val = 0;
    for (int i = MAX_BITS - 1; i >= 0; i--) {
        int bit = (val >> i) & 1;
        if (trie_nodes[curr].children[1 - bit] != 0) {
            max_xor_val |= (1 << i);
            curr = trie_nodes[curr].children[1 - bit];
        } else if (trie_nodes[curr].children[bit] != 0) {
            curr = trie_nodes[curr].children[bit];
        } else {
            return 0; 
        }
    }
    return max_xor_val;
}

int* seg_tree_trie_roots;
int* P_prefix_xor;

void build_seg_tree(int node_idx, int x_start, int x_end) {
    seg_tree_trie_roots[node_idx] = new_trie_node();

    for (int i = x_start; i <= x_end; i++) {
        insert_into_trie(seg_tree_trie_roots[node_idx], P_prefix_xor[i]);
    }

    if (x_start == x_end) {
        return;
    } else {
        int mid = x_start + (x_end - x_start) / 2;
        build_seg_tree(2 * node_idx, x_start, mid);
        build_seg_tree(2 * node_idx + 1, mid + 1, x_end);
    }
}

int query_seg_tree(int node_idx, int x_start, int x_end, int query_L, int query_R, int target_val) {
    if (x_start > query_R || x_end < query_L) {
        return 0;
    }
    if (query_L <= x_start && x_end <= query_R) {
        return query_max_xor(seg_tree_trie_roots[node_idx], target_val);
    }
    int mid = x_start + (x_end - x_start) / 2;
    int res_left = query_seg_tree(2 * node_idx, x_start, mid, query_L, query_R, target_val);
    int res_right = query_seg_tree(2 * node_idx + 1, mid + 1, x_end, query_L, query_R, target_val);
    return (res_left > res_right) ? res_left : res_right;
}

int* max_xor_score_subarray_queries(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    P_prefix_xor = (int*)malloc(sizeof(int) * (numsSize + 1));
    P_prefix_xor[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        P_prefix_xor[i + 1] = P_prefix_xor[i] ^ nums[i];
    }

    trie_nodes = (TrieNode*)malloc(sizeof(TrieNode) * (4 * (numsSize + 1) * MAX_BITS + 5));
    trie_node_count = 1;

    seg_tree_trie_roots = (int*)malloc(sizeof(int) * (4 * (numsSize + 1) + 5));

    build_seg_tree(1, 0, numsSize);

    *returnSize = queriesSize;
    int* results = (int*)malloc(sizeof(int) * queriesSize);

    for (int q_idx = 0; q_idx < queriesSize; q_idx++) {
        int L_q = queries[q_idx][0];
        int R_q = queries[q_idx][1];

        int current_max_xor_score = 0;
        for (int y = L_q + 1; y <= R_q + 1; y++) {
            int res = query_seg_tree(1, 0, numsSize, L_q, y - 1, P_prefix_xor[y]);
            if (res > current_max_xor_score) {
                current_max_xor_score = res;
            }
        }
        results[q_idx] = current_max_xor_score;
    }

    free(P_prefix_xor);
    free(trie_nodes);
    free(seg_tree_trie_roots);

    return results;
}