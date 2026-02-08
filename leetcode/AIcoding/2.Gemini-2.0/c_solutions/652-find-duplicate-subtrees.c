#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct TreeNode TreeNode;

char* serialize(TreeNode* root, char* str) {
    if (!root) {
        str = strcat(str, "null,");
        return str;
    }
    char val_str[12];
    sprintf(val_str, "%d,", root->val);
    str = strcat(str, val_str);
    str = serialize(root->left, str);
    str = serialize(root->right, str);
    return str;
}

struct TreeNode** findDuplicateSubtrees(struct TreeNode* root, int* returnSize){
    *returnSize = 0;
    struct TreeNode** result = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * 1000);
    char** seen = (char**)malloc(sizeof(char*) * 1000);
    int seenSize = 0;

    char** duplicates = (char**)malloc(sizeof(char*) * 1000);
    int duplicatesSize = 0;

    void dfs(TreeNode* node) {
        if (!node) return;

        char* str = (char*)malloc(sizeof(char) * 10000);
        str[0] = '\0';
        serialize(node, str);

        int found = 0;
        for (int i = 0; i < seenSize; i++) {
            if (strcmp(str, seen[i]) == 0) {
                found = 1;
                break;
            }
        }

        if (found) {
            int isDuplicate = 0;
            for (int i = 0; i < duplicatesSize; i++) {
                if (strcmp(str, duplicates[i]) == 0) {
                    isDuplicate = 1;
                    break;
                }
            }
            if (!isDuplicate) {
                duplicates[duplicatesSize++] = strdup(str);
                result[(*returnSize)++] = node;
            } else {
                free(str);
            }
        } else {
            seen[seenSize++] = str;
        }

        dfs(node->left);
        dfs(node->right);
    }

    dfs(root);

    for (int i = 0; i < seenSize; i++) {
        free(seen[i]);
    }
    free(seen);
    for (int i = 0; i < duplicatesSize; i++) {
        free(duplicates[i]);
    }
    free(duplicates);

    return result;
}