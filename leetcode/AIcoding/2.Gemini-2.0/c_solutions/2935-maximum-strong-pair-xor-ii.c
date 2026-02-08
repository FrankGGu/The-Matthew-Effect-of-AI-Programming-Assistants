#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode* children[2];
    int count;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->children[0] = node->children[1] = NULL;
    node->count = 0;
    return node;
}

void insert(TrieNode* root, int num) {
    TrieNode* curr = root;
    for (int i = 20; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (!curr->children[bit]) {
            curr->children[bit] = createNode();
        }
        curr = curr->children[bit];
        curr->count++;
    }
}

void removeNum(TrieNode* root, int num) {
    TrieNode* curr = root;
    for (int i = 20; i >= 0; i--) {
        int bit = (num >> i) & 1;
        curr = curr->children[bit];
        curr->count--;
    }
}

int findMaxXor(TrieNode* root, int num) {
    TrieNode* curr = root;
    int maxXor = 0;
    for (int i = 20; i >= 0; i--) {
        int bit = (num >> i) & 1;
        int oppositeBit = 1 - bit;
        if (curr->children[oppositeBit] && curr->children[oppositeBit]->count > 0) {
            maxXor |= (1 << i);
            curr = curr->children[oppositeBit];
        } else {
            curr = curr->children[bit];
        }
    }
    return maxXor;
}

int maximumStrongPairXor(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    TrieNode* root = createNode();
    int left = 0;
    int maxXor = 0;
    for (int right = 0; right < numsSize; right++) {
        insert(root, nums[right]);
        while (nums[right] > 2 * nums[left]) {
            removeNum(root, nums[left]);
            left++;
        }
        maxXor = fmax(maxXor, findMaxXor(root, nums[right]));
    }
    return maxXor;
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}