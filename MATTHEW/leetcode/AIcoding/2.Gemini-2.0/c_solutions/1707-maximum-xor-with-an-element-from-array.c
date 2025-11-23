#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode* children[2];
} TrieNode;

TrieNode* createTrieNode() {
    TrieNode* newNode = (TrieNode*)malloc(sizeof(TrieNode));
    newNode->children[0] = NULL;
    newNode->children[1] = NULL;
    return newNode;
}

void insert(TrieNode* root, int num) {
    TrieNode* curr = root;
    for (int i = 31; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (curr->children[bit] == NULL) {
            curr->children[bit] = createTrieNode();
        }
        curr = curr->children[bit];
    }
}

int findMaxXOR(TrieNode* root, int num) {
    TrieNode* curr = root;
    int maxXOR = 0;
    for (int i = 31; i >= 0; i--) {
        int bit = (num >> i) & 1;
        int oppositeBit = 1 - bit;
        if (curr->children[oppositeBit] != NULL) {
            maxXOR |= (1 << i);
            curr = curr->children[oppositeBit];
        } else {
            curr = curr->children[bit];
        }
    }
    return maxXOR;
}

int* maximizeXor(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    int* sortedNums = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sortedNums[i] = nums[i];
    }
    qsort(sortedNums, numsSize, sizeof(int), compare);

    int** sortedQueries = (int**)malloc(queriesSize * sizeof(int*));
    int* queryIndices = (int*)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        sortedQueries[i] = (int*)malloc(3 * sizeof(int));
        sortedQueries[i][0] = queries[i][0];
        sortedQueries[i][1] = queries[i][1];
        sortedQueries[i][2] = i;
        queryIndices[i] = i;
    }

    qsort(sortedQueries, queriesSize, sizeof(int*), compareQueries);

    TrieNode* root = createTrieNode();
    int numIndex = 0;

    for (int i = 0; i < queriesSize; i++) {
        int x = sortedQueries[i][0];
        int limit = sortedQueries[i][1];
        int originalIndex = sortedQueries[i][2];

        while (numIndex < numsSize && sortedNums[numIndex] <= limit) {
            insert(root, sortedNums[numIndex]);
            numIndex++;
        }

        if (numIndex == 0) {
            result[originalIndex] = -1;
        } else {
            result[originalIndex] = findMaxXOR(root, x);
        }
    }

    for(int i = 0; i < queriesSize; i++) {
        free(sortedQueries[i]);
    }
    free(sortedQueries);
    free(queryIndices);
    free(sortedNums);

    TrieNode* curr = root;
    freeTrie(root);

    return result;
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int compareQueries(const void* a, const void* b) {
    return (*(int**)a)[1] - (*(int**)b)[1];
}

void freeTrie(TrieNode* root) {
    if (root == NULL) return;
    for (int i = 0; i < 2; i++) {
        freeTrie(root->children[i]);
    }
    free(root);
}