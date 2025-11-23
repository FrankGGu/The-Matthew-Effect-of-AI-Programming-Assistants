#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    int sum;
    int count;
} SumCount;

typedef struct {
    int key;
    int value;
} Pair;

int cmp(const void *a, const void *b) {
    return ((Pair*)b)->value - ((Pair*)a)->value;
}

void dfs(struct TreeNode* root, int* sum_map, int* sum_count, int* size) {
    if (!root) return;
    int sum = root->val;
    if (root->left) {
        dfs(root->left, sum_map, sum_count, size);
        sum += sum_map[root->left->val];
    }
    if (root->right) {
        dfs(root->right, sum_map, sum_count, size);
        sum += sum_map[root->right->val];
    }

    sum_map[sum]++;
    if (sum_map[sum] > sum_count[0]) {
        sum_count[0] = sum_map[sum];
        *size = 1;
        sum_count[*size] = sum;
    } else if (sum_map[sum] == sum_count[0]) {
        sum_count[++(*size)] = sum;
    }
}

int* findFrequentTreeSum(struct TreeNode* root, int* returnSize) {
    int* sum_map = (int*)calloc(10000, sizeof(int));
    int* sum_count = (int*)calloc(10000, sizeof(int));
    *returnSize = 0;

    dfs(root, sum_map, sum_count, returnSize);

    qsort(sum_count + 1, *returnSize, sizeof(int), cmp);

    int* result = (int*)malloc((*returnSize) * sizeof(int));
    for (int i = 1; i <= *returnSize; i++) {
        result[i - 1] = sum_count[i];
    }

    free(sum_map);
    free(sum_count);
    return result;
}