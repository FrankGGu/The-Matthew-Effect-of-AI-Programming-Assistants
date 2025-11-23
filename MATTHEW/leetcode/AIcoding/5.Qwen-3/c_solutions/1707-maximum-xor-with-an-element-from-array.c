#include <stdio.h>
#include <stdlib.h>

typedef struct TrieNode {
    struct TrieNode* children[2];
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->children[0] = NULL;
    node->children[1] = NULL;
    return node;
}

void insert(TrieNode* root, int num) {
    TrieNode* node = root;
    for (int i = 31; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (!node->children[bit]) {
            node->children[bit] = createNode();
        }
        node = node->children[bit];
    }
}

int query(TrieNode* root, int num) {
    TrieNode* node = root;
    int max_xor = 0;
    for (int i = 31; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (node->children[1 - bit]) {
            max_xor |= (1 << i);
            node = node->children[1 - bit];
        } else {
            node = node->children[bit];
        }
    }
    return max_xor;
}

int* maximizeXOR(int* nums, int numsSize, int* queries, int queriesSize, int* returnSize) {
    TrieNode* root = createNode();
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    int* sortedQueries = (int*)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        sortedQueries[i] = i;
    }

    for (int i = 0; i < queriesSize; i++) {
        for (int j = i + 1; j < queriesSize; j++) {
            if (queries[sortedQueries[i]] > queries[sortedQueries[j]]) {
                int temp = sortedQueries[i];
                sortedQueries[i] = sortedQueries[j];
                sortedQueries[j] = temp;
            }
        }
    }

    int idx = 0;
    for (int i = 0; i < queriesSize; i++) {
        int qIdx = sortedQueries[i];
        int qVal = queries[qIdx];
        while (idx < numsSize && nums[idx] <= qVal) {
            insert(root, nums[idx]);
            idx++;
        }
        if (idx == 0) {
            result[qIdx] = 0;
        } else {
            result[qIdx] = query(root, qVal);
        }
    }

    free(sortedQueries);
    return result;
}