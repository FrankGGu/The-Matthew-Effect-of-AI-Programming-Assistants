#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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
    for (int i = 30; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (!node->children[bit]) {
            node->children[bit] = createNode();
        }
        node = node->children[bit];
    }
}

int queryMaxXOR(TrieNode* root, int num) {
    TrieNode* node = root;
    int max_xor = 0;
    for (int i = 30; i >= 0; i--) {
        int bit = (num >> i) & 1;
        int toggled_bit = 1 - bit;
        if (node->children[toggled_bit]) {
            max_xor |= (1 << i);
            node = node->children[toggled_bit];
        } else {
            node = node->children[bit];
        }
    }
    return max_xor;
}

void deleteTrie(TrieNode* root) {
    if (!root) return;
    deleteTrie(root->children[0]);
    deleteTrie(root->children[1]);
    free(root);
}

int* getMaximumXor(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    TrieNode* root = createNode();

    int max_num = 0;
    for (int i = 0; i < numsSize; i++) {
        max_num = (nums[i] > max_num) ? nums[i] : max_num;
    }

    int max_bit = 0;
    while ((1 << max_bit) <= max_num) {
        max_bit++;
    }

    for (int i = 0; i < queriesSize; i++) {
        int index = queries[i][0];
        int val = queries[i][1];
        insert(root, nums[index]);
        result[i] = queryMaxXOR(root, val);
    }

    deleteTrie(root);
    return result;
}