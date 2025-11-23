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
    TrieNode* curr = root;
    for (int i = 31; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (!curr->children[bit]) {
            curr->children[bit] = createNode();
        }
        curr = curr->children[bit];
    }
}

int query(TrieNode* root, int num) {
    TrieNode* curr = root;
    int maxXor = 0;
    for (int i = 31; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (curr->children[1 - bit]) {
            maxXor |= (1 << i);
            curr = curr->children[1 - bit];
        } else {
            curr = curr->children[bit];
        }
    }
    return maxXor;
}

int* maxXorQueries(int* nums, int numsSize, int** queries, int queriesSize, int* returnSize) {
    int* results = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;

    qsort(nums, numsSize, sizeof(int), (int (*)(const void *, const void *))compare);

    TrieNode* root = createNode();
    for (int i = 0; i < numsSize; i++) {
        insert(root, nums[i]);
    }

    for (int i = 0; i < queriesSize; i++) {
        results[i] = query(root, queries[i][0]);
    }

    return results;
}

int compare(const int* a, const int* b) {
    return a[1] - b[1];
}