#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* displayFirstThreeRows(struct TreeNode* root, int* returnSize){
    *returnSize = 0;
    if (!root) return NULL;

    int* result = (int*)malloc(7 * sizeof(int));
    if (!result) return NULL;

    struct TreeNode* queue[8];
    int head = 0, tail = 0;
    queue[tail++] = root;

    int level = 0;
    int nodesInLevel = 1;
    int nodesInNextLevel = 0;
    int index = 0;

    while (level < 3 && head < tail) {
        for (int i = 0; i < nodesInLevel; i++) {
            struct TreeNode* node = queue[head++];
            if (node) {
                result[index++] = node->val;
                queue[tail++] = node->left;
                queue[tail++] = node->right;
                nodesInNextLevel += 2;
            } else {
                result[index++] = -1; 
                queue[tail++] = NULL;
                queue[tail++] = NULL;
                nodesInNextLevel += 2;
            }
        }

        nodesInLevel = nodesInNextLevel;
        nodesInNextLevel = 0;
        level++;
    }

    *returnSize = index;
    return result;
}