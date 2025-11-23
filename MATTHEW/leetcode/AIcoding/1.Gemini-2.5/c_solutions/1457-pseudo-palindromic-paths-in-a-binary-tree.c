int pseudoPalindromicCount;

void dfs(struct TreeNode* node, int pathMask) {
    if (node == NULL) {
        return;
    }

    pathMask ^= (1 << node->val);

    if (node->left == NULL && node->right == NULL) {
        if ((pathMask & (pathMask - 1)) == 0) {
            pseudoPalindromicCount++;
        }
    } else {
        dfs(node->left, pathMask);
        dfs(node->right, pathMask);
    }
}

int pseudoPalindromicPaths(struct TreeNode* root) {
    pseudoPalindromicCount = 0;
    dfs(root, 0);
    return pseudoPalindromicCount;
}