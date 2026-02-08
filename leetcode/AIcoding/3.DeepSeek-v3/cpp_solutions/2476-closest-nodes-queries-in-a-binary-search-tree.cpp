class Solution {
public:
    vector<vector<int>> closestNodes(TreeNode* root, vector<int>& queries) {
        vector<int> sorted;
        inorder(root, sorted);
        vector<vector<int>> res;
        for (int q : queries) {
            auto it = lower_bound(sorted.begin(), sorted.end(), q);
            int min_val = -1, max_val = -1;
            if (it != sorted.end()) {
                max_val = *it;
                if (*it == q) {
                    min_val = max_val;
                    res.push_back({min_val, max_val});
                    continue;
                }
            }
            if (it != sorted.begin()) {
                min_val = *(--it);
            }
            res.push_back({min_val, max_val});
        }
        return res;
    }

    void inorder(TreeNode* root, vector<int>& sorted) {
        if (!root) return;
        inorder(root->left, sorted);
        sorted.push_back(root->val);
        inorder(root->right, sorted);
    }
};