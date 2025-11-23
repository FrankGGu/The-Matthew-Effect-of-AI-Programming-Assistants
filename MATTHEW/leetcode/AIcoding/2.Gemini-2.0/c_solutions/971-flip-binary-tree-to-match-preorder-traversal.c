#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int* flipMatchVoyage(struct TreeNode* root, int* voyage, int voyageSize, int* returnSize) {
    int* flipped = (int*)malloc(sizeof(int) * voyageSize);
    *returnSize = 0;
    int i = 0;

    int solve(struct TreeNode* node, int* voyage, int voyageSize, int* i, int* flipped, int* returnSize) {
        if (!node) return 1;

        if (node->val != voyage[*i]) return 0;

        (*i)++;

        if (node->left && node->left->val != voyage[*i]) {
            if (node->right && node->right->val == voyage[*i]) {
                struct TreeNode* temp = node->left;
                node->left = node->right;
                node->right = temp;

                flipped[(*returnSize)++] = node->val;
            } else {
                return 0;
            }
        }

        if (!solve(node->left, voyage, voyageSize, i, flipped, returnSize)) return 0;
        if (!solve(node->right, voyage, voyageSize, i, flipped, returnSize)) return 0;

        return 1;
    }

    if (solve(root, voyage, voyageSize, &i, flipped, returnSize)) {
        if (*returnSize == 0) {
            free(flipped);
            flipped = (int*)malloc(sizeof(int));
            flipped[0] = -1;
            *returnSize = 1;
        } else {
             flipped = (int*)realloc(flipped, sizeof(int) * (*returnSize));
        }
        return flipped;
    } else {
        free(flipped);
        flipped = (int*)malloc(sizeof(int));
        flipped[0] = -1;
        *returnSize = 1;
        return flipped;
    }
}