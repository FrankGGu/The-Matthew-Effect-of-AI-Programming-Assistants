int idx;

bool dfs(struct TreeNode* node, int* voyage, int voyageSize, int* res, int* resSize) {
    if (!node) return true;
    if (node->val != voyage[idx++]) return false;

    if (node->left && node->left->val != voyage[idx]) {
        res[(*resSize)++] = node->val;
        return dfs(node->right, voyage, voyageSize, res, resSize) && 
               dfs(node->left, voyage, voyageSize, res, resSize);
    }
    return dfs(node->left, voyage, voyageSize, res, resSize) && 
           dfs(node->right, voyage, voyageSize, res, resSize);
}

int* flipMatchVoyage(struct TreeNode* root, int* voyage, int voyageSize, int* returnSize) {
    int* res = malloc(voyageSize * sizeof(int));
    *returnSize = 0;
    idx = 0;

    if (!dfs(root, voyage, voyageSize, res, returnSize)) {
        *returnSize = 1;
        res[0] = -1;
    }

    return res;
}