#include <stdlib.h> // For malloc and free

typedef struct TrieNode {
    struct TrieNode* children[2]; // children[0] for bit 0, children[1] for bit 1
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->children[0] = NULL;
    node->children[1] = NULL;
    return node;
}

void insert(TrieNode* root, int num) {
    TrieNode* curr = root;
    // Iterate from the most significant bit (30th bit for 31-bit integers) down to the least significant bit (0th bit)
    for (int i = 30; i >= 0; i--) {
        int bit = (num >> i) & 1; // Get the i-th bit of the number
        if (curr->children[bit] == NULL) {
            curr->children[bit] = createNode();
        }
        curr = curr->children[bit];
    }
}

int findMaxXor(TrieNode* root, int num) {
    TrieNode* curr = root;
    int maxXor = 0;
    // Iterate from the most significant bit down to the least significant bit
    for (int i = 30; i >= 0; i--) {
        int bit = (num >> i) & 1; // Get the i-th bit of the current number
        // Try to find the opposite bit in the Trie to maximize XOR
        if (curr->children[1 - bit] != NULL) {
            maxXor |= (1 << i); // If opposite bit exists, set the i-th bit in maxXor
            curr = curr->children[1 - bit];
        } else {
            // If opposite bit does not exist, we must take the same bit
            curr = curr->children[bit];
        }
    }
    return maxXor;
}

void freeTrie(TrieNode* root) {
    if (!root) {
        return;
    }
    freeTrie(root->children[0]);
    freeTrie(root->children[1]);
    free(root);
}

int findMaximumXOR(int* nums, int numsSize) {
    if (numsSize < 2) {
        return 0; // Need at least two numbers to form a pair
    }

    TrieNode* root = createNode();
    int maxOverallXor = 0;

    // Insert the first number into the Trie
    insert(root, nums[0]);

    // Iterate through the rest of the numbers
    for (int i = 1; i < numsSize; i++) {
        // For each number, find its maximum XOR with numbers ALREADY in the Trie
        int currentMaxXor = findMaxXor(root, nums[i]);
        if (currentMaxXor > maxOverallXor) {
            maxOverallXor = currentMaxXor;
        }
        // Then, insert the current number into the Trie for future comparisons
        insert(root, nums[i]);
    }

    // Free the allocated Trie memory
    freeTrie(root);

    return maxOverallXor;
}