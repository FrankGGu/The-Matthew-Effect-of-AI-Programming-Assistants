int min_diff_global;
int prev_val_global;

void inorder_traverse(struct TreeNode* root) {
    if (root == NULL) {
        return;
    }

    inorder_traverse(root->left);

    if (prev_val_global != -1) {
        int current_diff = root->val - prev_val_global;
        if (current_diff < min_diff_global) {
            min_diff_global = current_diff;
        }
    }
    prev_val_global = root->val;

    inorder_traverse(root->right);
}

int minDiffInBST(struct TreeNode* root) {
    min_diff_global = 100001; 
    prev_val_global = -1;    

    inorder_traverse(root);

    return min_diff_global;
}