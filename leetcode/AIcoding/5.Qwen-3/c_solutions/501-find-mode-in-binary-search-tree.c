#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int* findMode(struct TreeNode* root, int* returnSize) {
    int* result = NULL;
    int count = 0;
    int maxCount = 0;
    int prevVal = 0;
    int* temp = NULL;

    struct TreeNode* current = root;
    struct TreeNode* prev = NULL;

    while (current) {
        if (!current->left) {
            if (prev && prev->val == current->val) {
                count++;
            } else {
                count = 1;
            }
            if (count > maxCount) {
                maxCount = count;
                temp = realloc(result, sizeof(int) * maxCount);
                if (!temp) {
                    free(result);
                    return NULL;
                }
                result = temp;
                result[0] = current->val;
                *returnSize = 1;
            } else if (count == maxCount) {
                temp = realloc(result, sizeof(int) * (*returnSize + 1));
                if (!temp) {
                    free(result);
                    return NULL;
                }
                result = temp;
                result[*returnSize] = current->val;
                (*returnSize)++;
            }
            prev = current;
            current = current->right;
        } else {
            struct TreeNode* rightmost = current->left;
            while (rightmost->right && rightmost->right != current) {
                rightmost = rightmost->right;
            }

            if (!rightmost->right) {
                rightmost->right = current;
                current = current->left;
            } else {
                rightmost->right = NULL;
                if (prev && prev->val == current->val) {
                    count++;
                } else {
                    count = 1;
                }
                if (count > maxCount) {
                    maxCount = count;
                    temp = realloc(result, sizeof(int) * maxCount);
                    if (!temp) {
                        free(result);
                        return NULL;
                    }
                    result = temp;
                    result[0] = current->val;
                    *returnSize = 1;
                } else if (count == maxCount) {
                    temp = realloc(result, sizeof(int) * (*returnSize + 1));
                    if (!temp) {
                        free(result);
                        return NULL;
                    }
                    result = temp;
                    result[*returnSize] = current->val;
                    (*returnSize)++;
                }
                prev = current;
                current = current->right;
            }
        }
    }

    return result;
}