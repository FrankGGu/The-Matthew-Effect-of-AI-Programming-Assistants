#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode* children[2];
} TrieNode;

TrieNode* createNode() {
    TrieNode* newNode = (TrieNode*)malloc(sizeof(TrieNode));
    newNode->children[0] = newNode->children[1] = NULL;
    return newNode;
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

int findMaximumXOR(int* nums, int numsSize) {
    TrieNode* root = createNode();
    for (int i = 0; i < numsSize; i++) {
        insert(root, nums[i]);
    }

    int maxXOR = 0;
    for (int i = 0; i < numsSize; i++) {
        TrieNode* curr = root;
        int num = nums[i];
        int currXOR = 0;
        for (int j = 31; j >= 0; j--) {
            int bit = (num >> j) & 1;
            int oppositeBit = 1 - bit;
            if (curr->children[oppositeBit]) {
                currXOR += (1 << j);
                curr = curr->children[oppositeBit];
            } else {
                curr = curr->children[bit];
            }
        }
        maxXOR = (maxXOR > currXOR) ? maxXOR : currXOR;
    }

    return maxXOR;
}