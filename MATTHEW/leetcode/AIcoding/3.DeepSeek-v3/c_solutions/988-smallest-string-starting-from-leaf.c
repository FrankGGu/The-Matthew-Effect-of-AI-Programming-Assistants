/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

void dfs(struct TreeNode* node, char* current, int index, char** smallest) {
    if (!node) return;

    current[index] = 'a' + node->val;

    if (!node->left && !node->right) {
        current[index + 1] = '\0';

        int len = strlen(current);
        char* reversed = malloc(len + 1);
        for (int i = 0; i < len; i++) {
            reversed[i] = current[len - 1 - i];
        }
        reversed[len] = '\0';

        if (*smallest == NULL || strcmp(reversed, *smallest) < 0) {
            free(*smallest);
            *smallest = reversed;
        } else {
            free(reversed);
        }
        return;
    }

    if (node->left) dfs(node->left, current, index + 1, smallest);
    if (node->right) dfs(node->right, current, index + 1, smallest);
}

char* smallestFromLeaf(struct TreeNode* root) {
    char* smallest = NULL;
    char* current = malloc(8501);
    dfs(root, current, 0, &smallest);
    free(current);
    return smallest ? smallest : strdup("");
}