#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int countUniqueValues(struct TreeNode* root, int* uniqueValues, int* count) {
    if (root == NULL) {
        return 0;
    }

    int leftCount = countUniqueValues(root->left, uniqueValues, count);
    int rightCount = countUniqueValues(root->right, uniqueValues, count);

    int found = 0;
    for (int i = 0; i < *count; i++) {
        if (uniqueValues[i] == root->val) {
            found = 1;
            break;
        }
    }

    if (!found) {
        uniqueValues[*count] = root->val;
        (*count)++;
    }

    return *count;
}

int numColor(struct TreeNode* root) {
    if (root == NULL) {
        return 0;
    }

    int* uniqueValues = (int*)malloc(100001 * sizeof(int));
    int count = 0;

    countUniqueValues(root, uniqueValues, &count);

    free(uniqueValues);

    return count;
}