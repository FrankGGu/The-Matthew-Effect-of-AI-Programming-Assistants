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
    for (int i = 30; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (curr->children[bit] == NULL) {
            curr->children[bit] = createNode();
        }
        curr = curr->children[bit];
    }
}

int findMaxXor(TrieNode* root, int num) {
    TrieNode* curr = root;
    int current_xor_sum = 0;
    for (int i = 30; i >= 0; i--) {
        int bit = (num >> i) & 1;
        int desired_bit = 1 - bit;

        if (curr->children[desired_bit] != NULL) {
            current_xor_sum |= (1 << i);
            curr = curr->children[desired_bit];
        } else {
            curr = curr->children[bit];
        }
    }
    return current_xor_sum;
}

void freeTrie(TrieNode* node) {
    if (!node) return;
    freeTrie(node->children[0]);
    freeTrie(node->children[1]);
    free(node);
}

int findMaximumXOR(int* nums, int numsSize) {
    if (numsSize < 1) {
        return 0;
    }

    TrieNode* root = createNode();

    for (int i = 0; i < numsSize; i++) {
        insert(root, nums[i]);
    }

    int max_xor_val = 0;

    for (int i = 0; i < numsSize; i++) {
        int current_xor = findMaxXor(root, nums[i]);
        if (current_xor > max_xor_val) {
            max_xor_val = current_xor;
        }
    }

    freeTrie(root);

    return max_xor_val;
}