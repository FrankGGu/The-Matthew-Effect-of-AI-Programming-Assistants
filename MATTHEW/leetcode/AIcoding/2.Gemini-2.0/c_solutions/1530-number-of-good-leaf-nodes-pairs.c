#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int countPairs(struct TreeNode* root, int distance) {
    int count = 0;

    int* dfs(struct TreeNode* node) {
        if (!node) {
            return NULL;
        }

        if (!node->left && !node->right) {
            int* leaves = (int*)malloc(sizeof(int) * 10);
            for (int i = 0; i < 10; i++) {
                leaves[i] = 0;
            }
            leaves[0] = 1;
            return leaves;
        }

        int* leftLeaves = dfs(node->left);
        int* rightLeaves = dfs(node->right);

        int* leaves = (int*)malloc(sizeof(int) * 11);
        for (int i = 0; i < 11; i++) {
            leaves[i] = 0;
        }

        if (leftLeaves) {
            for (int i = 0; i < 10; i++) {
                if (leftLeaves[i] > 0) {
                    leaves[i + 1] += leftLeaves[i];
                }
            }
            free(leftLeaves);
        }

        if (rightLeaves) {
            for (int i = 0; i < 10; i++) {
                if (rightLeaves[i] > 0) {
                    leaves[i + 1] += rightLeaves[i];
                }
            }
            free(rightLeaves);
        }

        for (int i = 1; i <= distance; i++) {
            for (int j = 1; j <= distance; j++) {
                if (i + j <= distance) {
                    int leftCount = 0;
                    if (node->left) {
                        int* tempLeftLeaves = dfs(node->left);
                        if (tempLeftLeaves) {
                            leftCount = tempLeftLeaves[i - 1];
                            free(tempLeftLeaves);
                        }
                    }
                    int rightCount = 0;
                    if (node->right) {
                        int* tempRightLeaves = dfs(node->right);
                        if (tempRightLeaves) {
                            rightCount = tempRightLeaves[j - 1];
                            free(tempRightLeaves);
                        }
                    }

                    if(node->left && node->right){
                        int* tempLeftLeaves = dfs(node->left);
                        int* tempRightLeaves = dfs(node->right);
                        if(tempLeftLeaves && tempRightLeaves){
                            count += tempLeftLeaves[i-1] * tempRightLeaves[j-1];
                            free(tempLeftLeaves);
                            free(tempRightLeaves);
                        }
                    }
                }
            }
        }
        return leaves;
    }

    dfs(root);
    return count;
}