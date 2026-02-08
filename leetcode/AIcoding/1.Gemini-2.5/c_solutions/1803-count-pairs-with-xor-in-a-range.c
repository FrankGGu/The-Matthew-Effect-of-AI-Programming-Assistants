#include <stdlib.h> // Required for malloc and free

#define MAX_BIT_INDEX 30

typedef struct TrieNode {
    struct TrieNode *children[2]; // children[0] for bit 0, children[1] for bit 1
    int count;                    // Number of elements whose prefix passes through this node
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    // In a competitive programming context, explicit error handling for malloc is often omitted
    // as memory allocation is usually guaranteed for reasonable constraints.
    // For robust production code, checks for NULL return from malloc are essential.
    node->children[0] = NULL;
    node->children[1] = NULL;
    node->count = 0;
    return node;
}

void insert(TrieNode* root, int num) {
    TrieNode* curr = root;
    for (int i = MAX_BIT_INDEX; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (curr->children[bit] == NULL) {
            curr->children[bit] = createNode();
        }
        curr = curr->children[bit];
        curr->count++; // Increment count for the path passing through this node
    }
}

int count_le(TrieNode* root, int num, int limit) {
    // If limit is negative, no non-negative XOR sum can be less than or equal to it.
    // XOR sums are always non-negative for non-negative numbers.
    if (limit < 0) {
        return 0;
    }

    TrieNode* curr = root;
    int count = 0;
    for (int i = MAX_BIT_INDEX; i >= 0 && curr != NULL; i--) {
        int num_bit = (num >> i) & 1;
        int limit_bit = (limit >> i) & 1;

        // Case 1: We try to make the current XOR bit 0 (i.e., x_bit == num_bit)
        // This corresponds to traversing `curr->children[num_bit]`.
        if (limit_bit == 1) {
            // If the limit's current bit is 1, and we make the XOR bit 0,
            // then 0 < 1. This path is definitely less than the limit for this bit.
            // All numbers in the subtree rooted at `curr->children[num_bit]` will satisfy
            // the condition for this bit and all subsequent bits, regardless of their values.
            if (curr->children[num_bit] != NULL) {
                count += curr->children[num_bit]->count;
            }
            // Now, we must continue down the path where (num_bit XOR x_bit) == 1
            // (i.e., x_bit == 1 - num_bit) to see if we can still satisfy the limit.
            curr = curr->children[1 - num_bit];
        } else { // limit_bit == 0
            // If the limit's current bit is 0, and we make the XOR bit 0,
            // then 0 == 0. We must continue down this path to ensure subsequent bits also satisfy.
            // This means we must choose x_bit = num_bit.
            curr = curr->children[num_bit];
            // We cannot take the path where XOR bit is 1 (i.e., x_bit == 1 - num_bit),
            // because 1 > 0, which would exceed the limit at this bit position.
        }
    }

    // After the loop, if `curr` is not NULL, it means we have successfully followed a path
    // where `num XOR x` exactly matches `limit` for all bits considered.
    // In this case, all numbers in the subtree rooted at `curr` (which is just `curr` itself
    // if it's a leaf representing a full number) satisfy the condition.
    if (curr != NULL) {
        count += curr->count;
    }
    return count;
}

void freeTrie(TrieNode* node) {
    if (node == NULL) return;
    freeTrie(node->children[0]);
    freeTrie(node->children[1]);
    free(node);
}

long long countPairs(int* nums, int numsSize, int low, int high) {
    TrieNode* root = createNode();
    long long total_pairs = 0;

    // Iterate through each number in the array
    for (int i = 0; i < numsSize; i++) {
        // For each nums[i], we want to count pairs (nums[j], nums[i]) where j < i
        // such that low <= (nums[j] XOR nums[i]) <= high.
        // This can be calculated as:
        // (count of nums[j] such that (nums[j] XOR nums[i]) <= high)
        // - (count of nums[j] such that (nums[j] XOR nums[i]) < low)
        // which is equivalent to:
        // count_le(root, nums[i], high) - count_le(root, nums[i], low - 1)

        total_pairs += count_le(root, nums[i], high) - count_le(root, nums[i], low - 1);

        // After querying, insert nums[i] into the Trie so it can be used for future queries
        // (i.e., for nums[k] where k > i).
        insert(root, nums[i]);
    }

    // Free the memory allocated for the Trie to prevent memory leaks
    freeTrie(root);

    return total_pairs;
}