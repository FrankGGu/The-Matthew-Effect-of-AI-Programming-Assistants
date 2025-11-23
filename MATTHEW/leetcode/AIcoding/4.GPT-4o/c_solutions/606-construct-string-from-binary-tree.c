char *tree2str(struct TreeNode* root) {
    if (!root) return "";
    char *left = tree2str(root->left);
    char *right = tree2str(root->right);
    char *result = (char *)malloc(1000); // Assuming a maximum length, can be adjusted
    if (right[0] == '\0') {
        sprintf(result, "%d(%s)", root->val, left);
    } else {
        sprintf(result, "%d(%s)(%s)", root->val, left, right);
    }
    return result;
}