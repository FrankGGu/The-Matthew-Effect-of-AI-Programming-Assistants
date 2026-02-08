#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

char* smallestFromLeaf(struct TreeNode* root) {
    char* ans = NULL;
    char path[10001];
    int pathLen = 0;

    void dfs(struct TreeNode* node) {
        if (!node) return;

        path[pathLen++] = 'a' + node->val;
        path[pathLen] = '\0';

        if (!node->left && !node->right) {
            char* current = (char*)malloc(sizeof(char) * (pathLen + 1));
            int i;
            for (i = 0; i < pathLen; i++) {
                current[i] = path[pathLen - 1 - i];
            }
            current[pathLen] = '\0';

            if (!ans || strcmp(current, ans) < 0) {
                if (ans) free(ans);
                ans = current;
            } else {
                free(current);
            }
        } else {
            dfs(node->left);
            dfs(node->right);
        }

        pathLen--;
    }

    dfs(root);
    return ans;
}