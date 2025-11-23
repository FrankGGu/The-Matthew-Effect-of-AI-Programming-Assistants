#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int val;
    struct Node* children[2];
} Node;

Node* createNode() {
    Node* node = (Node*)malloc(sizeof(Node));
    node->val = 0;
    node->children[0] = node->children[1] = NULL;
    return node;
}

void insert(Node* root, int num) {
    Node* curr = root;
    for (int i = 31; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (curr->children[bit] == NULL) {
            curr->children[bit] = createNode();
        }
        curr = curr->children[bit];
    }
}

int maxXor(Node* root, int num) {
    Node* curr = root;
    int maxXor = 0;
    for (int i = 31; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (curr->children[1 - bit] != NULL) {
            maxXor |= (1 << i);
            curr = curr->children[1 - bit];
        } else {
            curr = curr->children[bit];
        }
    }
    return maxXor;
}

int* maximizeXor(int* nums, int numsSize, int** queries, int queriesSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    int* sortedQueries = (int*)malloc(queriesSize * sizeof(int));
    int* indices = (int*)malloc(queriesSize * sizeof(int));

    for (int i = 0; i < queriesSize; i++) {
        sortedQueries[i] = queries[i][1];
        indices[i] = i;
    }

    qsort(indices, queriesSize, sizeof(int), [](const void* a, const void* b) {
        return sortedQueries[*(int*)a] - sortedQueries[*(int*)b];
    });

    qsort(nums, numsSize, sizeof(int), [](const void* a, const void* b) {
        return *(int*)a - *(int*)b;
    });

    Node* root = createNode();
    int j = 0;

    for (int i = 0; i < queriesSize; i++) {
        while (j < numsSize && nums[j] <= queries[indices[i]][1]) {
            insert(root, nums[j]);
            j++;
        }
        result[indices[i]] = (j > 0) ? maxXor(root, queries[indices[i]][0]) : -1;
    }

    free(sortedQueries);
    free(indices);
    returnSize[0] = queriesSize;
    return result;
}