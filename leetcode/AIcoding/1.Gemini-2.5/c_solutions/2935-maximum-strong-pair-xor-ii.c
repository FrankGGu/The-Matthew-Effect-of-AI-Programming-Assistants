#include <stdlib.h> // For malloc, free, qsort

#define MAX_BITS 30 // Numbers up to 10^9, which is less than 2^30. So bits 0 to 29.

typedef struct TrieNode {
    struct TrieNode* children[2];
    int count;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->children[0] = NULL;
    node->children[1] = NULL;
    node->count = 0;
    return node;
}

void insert(TrieNode* root, int num) {
    TrieNode* curr = root;
    for (int i = MAX_BITS - 1; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (curr->children[bit] == NULL) {
            curr->children[bit] = createNode();
        }
        curr = curr->children[bit];
        curr->count++;
    }
}

void removeNum(TrieNode* root, int num) {
    TrieNode* curr = root;
    for (int i = MAX_BITS - 1; i >= 0; i--) {
        int bit = (num >> i) & 1;
        curr = curr->children[bit];
        curr->count--;
    }
}

int queryMaxXor(TrieNode* root, int num) {
    TrieNode* curr = root;
    int maxXor = 0;
    for (int i = MAX_BITS - 1; i >= 0; i--) {
        int bit = (num >> i) & 1;
        int desiredBit = 1 - bit;
        if (curr->children[desiredBit] != NULL && curr->children[desiredBit]->count > 0) {
            maxXor |= (1 << i);
            curr = curr->children[desiredBit];
        } else {
            curr = curr->children[bit];
        }
    }
    return maxXor;
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

void freeTrie(TrieNode* node) {
    if (!node) return;
    freeTrie(node->children[0]);
    freeTrie(node->children[1]);
    free(node);
}

int maximumStrongPairXor(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    TrieNode* root = createNode();
    int maxXor = 0;
    int left = 0;
    int right = 0;

    for (int i = 0; i < numsSize; i++) {
        while (right < numsSize && nums[right] <= 2 * nums[i]) {
            insert(root, nums[right]);
            right++;
        }

        while (left < numsSize && nums[left] < nums[i]) {
            removeNum(root, nums[left]);
            left++;
        }

        int currentMax = queryMaxXor(root, nums[i]);
        if (currentMax > maxXor) {
            maxXor = currentMax;
        }
    }

    freeTrie(root);

    return maxXor;
}