#include <stdlib.h> // For malloc, free, qsort
#include <string.h> // For memset (though not strictly used, good to include for general C)

#define MAX_BITS 30

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
    // Iterate from the most significant bit to the least significant bit
    for (int i = MAX_BITS - 1; i >= 0; i--) {
        int bit = (num >> i) & 1; // Get the i-th bit of num
        if (curr->children[bit] == NULL) {
            curr->children[bit] = createNode(); // Create node if it doesn't exist
        }
        curr = curr->children[bit]; // Move to the next node
    }
}

int queryTrie(TrieNode* root, int x) {
    int max_xor = 0;
    TrieNode* curr = root;
    // Iterate from the most significant bit to the least significant bit
    for (int i = MAX_BITS - 1; i >= 0; i--) {
        int bit = (x >> i) & 1;           // Get the i-th bit of x
        int opposite_bit = 1 - bit;        // The bit we want to match for maximum XOR

        // If a child node for the opposite bit exists, take that path
        if (curr->children[opposite_bit] != NULL) {
            max_xor |= (1 << i); // Add (1 << i) to max_xor
            curr = curr->children[opposite_bit];
        } else {
            // Otherwise, we must take the path for the same bit
            // This path is guaranteed to exist if the Trie is not empty,
            // because numbers are fully inserted.
            curr = curr->children[bit];
        }
    }
    return max_xor;
}

void freeTrie(TrieNode* node) {
    if (!node) return;
    freeTrie(node->children[0]);
    freeTrie(node->children[1]);
    free(node);
}

typedef struct {
    int x;
    int m;
    int original_index;
} Query;

int compareNums(const void* a, const void* b) {
    return *(const int*)a - *(const int*)b;
}

int compareQueries(const void* a, const void* b) {
    return ((Query*)a)->m - ((Query*)b)->m;
}

int* maximizeXor(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    // Allocate memory for the result array
    *returnSize = queriesSize;
    int* ans = (int*)malloc(sizeof(int) * queriesSize);

    // Sort the nums array in ascending order
    qsort(nums, numsSize, sizeof(int), compareNums);

    // Create an array of Query structs to store queries with their original indices
    Query* sortedQueries = (Query*)malloc(sizeof(Query) * queriesSize);
    for (int i = 0; i < queriesSize; i++) {
        sortedQueries[i].x = queries[i][0];
        sortedQueries[i].m = queries[i][1];
        sortedQueries[i].original_index = i;
    }

    // Sort the queries array based on 'm' in ascending order
    qsort(sortedQueries, queriesSize, sizeof(Query), compareQueries);

    // Initialize the Trie
    TrieNode* root = createNode();
    int num_idx = 0;             // Pointer to iterate through the sorted nums array
    int nums_in_trie_count = 0;  // Counter for numbers currently in the Trie

    // Process each query
    for (int i = 0; i < queriesSize; i++) {
        int current_x = sortedQueries[i].x;
        int current_m = sortedQueries[i].m;
        int original_idx = sortedQueries[i].original_index;

        // Add all numbers from `nums` that are less than or equal to `current_m` into the Trie
        while (num_idx < numsSize && nums[num_idx] <= current_m) {
            insert(root, nums[num_idx]);
            nums_in_trie_count++;
            num_idx++;
        }

        // If no numbers were added to the Trie for the current 'm' (i.e., no number <= m exists),
        // the answer for this query is -1.
        if (nums_in_trie_count == 0) {
            ans[original_idx] = -1;
        } else {
            // Otherwise, query the Trie for the maximum XOR with current_x
            ans[original_idx] = queryTrie(root, current_x);
        }
    }

    // Free allocated memory for the Trie and sorted queries
    freeTrie(root);
    free(sortedQueries);

    return ans;
}