char* smallestFromLeaf(struct TreeNode* root) {
    if (!root) return "";
    char left[27] = "", right[27] = "";
    char* res = NULL;

    if (root->left) {
        res = smallestFromLeaf(root->left);
        sprintf(left, "%c%s", root->val, res);
    }
    if (root->right) {
        res = smallestFromLeaf(root->right);
        sprintf(right, "%c%s", root->val, res);
    }

    if (res) {
        if (left[0] && right[0]) {
            return strcmp(left, right) < 0 ? strdup(left) : strdup(right);
        }
        return left[0] ? strdup(left) : strdup(right);
    }

    return strdup((char[]){root->val, '\0'});
}