int count;

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int* dfs(struct TreeNode* node) {
    if (node == NULL) {
        int* res = malloc(2 * sizeof(int));
        res[0] = 0;
        res[1] = 0;
        return res;
    }

    int* left = dfs(node->left);
    int* right = dfs(node->right);

    int sum = node->val + left[0] + right[0];
    int nodes = 1 + left[1] + right[1];

    if (node->val == sum / nodes) {
        count++;
    }

    int* res = malloc(2 * sizeof(int));
    res[0] = sum;
    res[1] = nodes;

    free(left);
    free(right);

    return res;
}

int averageOfSubtree(struct TreeNode* root) {
    count = 0;
    int* result = dfs(root);
    free(result);
    return count;
}