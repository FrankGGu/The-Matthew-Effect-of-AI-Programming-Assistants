class Solution {
public:
    vector<vector<string>> printTree(TreeNode* root) {
        int height = getHeight(root);
        int m = height + 1;
        int n = (1 << (height + 1)) - 1;
        vector<vector<string>> res(m, vector<string>(n, ""));
        fill(res, root, 0, 0, n - 1);
        return res;
    }

private:
    int getHeight(TreeNode* root) {
        if (!root) return -1;
        return 1 + max(getHeight(root->left), getHeight(root->right));
    }

    void fill(vector<vector<string>>& res, TreeNode* root, int row, int left, int right) {
        if (!root) return;
        int mid = left + (right - left) / 2;
        res[row][mid] = to_string(root->val);
        fill(res, root->left, row + 1, left, mid - 1);
        fill(res, root->right, row + 1, mid + 1, right);
    }
};