class Solution {
public:
    int dfs(TreeNode* root, unordered_set<int>& s) {
        if (!root) return 0;
        int res = 0;
        if (s.find(root->val) == s.end()) {
            res++;
            s.insert(root->val);
        }
        res += dfs(root->left, s);
        res += dfs(root->right, s);
        return res;
    }

    int lightUp(TreeNode* root) {
        unordered_set<int> s;
        return dfs(root, s);
    }
};