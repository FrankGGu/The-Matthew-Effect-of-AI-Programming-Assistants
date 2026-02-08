#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findSubtreeSizes(struct TreeNode* root, int* queries, int queriesSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int target = queries[i];
        int count = 0;

        void traverse(struct TreeNode* node) {
            if (node == NULL) {
                return;
            }

            if (node->val == target) {

                void countNodes(struct TreeNode* subNode) {
                    if (subNode == NULL) {
                        return;
                    }
                    count++;
                    countNodes(subNode->left);
                    countNodes(subNode->right);
                }
                countNodes(node);
            } else {
                traverse(node->left);
                traverse(node->right);
            }
        }

        traverse(root);
        result[i] = count;
    }

    return result;
}