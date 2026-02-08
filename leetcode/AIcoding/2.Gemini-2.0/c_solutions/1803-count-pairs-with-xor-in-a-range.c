#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    int count;
    struct TrieNode* children[2];
} TrieNode;

TrieNode* createTrieNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->count = 0;
    node->children[0] = NULL;
    node->children[1] = NULL;
    return node;
}

void insert(TrieNode* root, int num) {
    TrieNode* curr = root;
    for (int i = 17; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (curr->children[bit] == NULL) {
            curr->children[bit] = createTrieNode();
        }
        curr = curr->children[bit];
        curr->count++;
    }
}

int countLessThan(TrieNode* root, int num, int limit) {
    TrieNode* curr = root;
    int count = 0;
    for (int i = 17; i >= 0; i--) {
        int numBit = (num >> i) & 1;
        int limitBit = (limit >> i) & 1;

        if (limitBit == 1) {
            if (curr->children[numBit] != NULL) {
                count += curr->children[numBit]->count;
            }
            if (curr->children[1 - numBit] == NULL) {
                return count;
            }
            curr = curr->children[1 - numBit];
        } else {
            if (curr->children[numBit] == NULL) {
                return count;
            }
            curr = curr->children[numBit];
        }
    }
    count += curr->count;
    return count;
}

int countPairs(int* nums, int numsSize, int low, int high) {
    TrieNode* root = createTrieNode();
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        count += countLessThan(root, nums[i], high + 1) - countLessThan(root, nums[i], low);
        insert(root, nums[i]);
    }
    return count;
}