#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

bool isCompleteTree(struct TreeNode* root) {
    if (!root) return true;

    struct TreeNode** queue = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * 1000);
    int head = 0, tail = 0;
    queue[tail++] = root;

    bool flag = false;

    while (head < tail) {
        struct TreeNode* node = queue[head++];

        if (!node) {
            flag = true;
        } else {
            if (flag) return false;
            queue[tail++] = node->left;
            queue[tail++] = node->right;
        }
    }

    free(queue);
    return true;
}