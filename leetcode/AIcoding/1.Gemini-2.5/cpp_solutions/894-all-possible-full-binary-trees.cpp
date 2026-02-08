class Solution {
public:
    vector<TreeNode*> allPossibleFBT(int n) {
        if (n % 2 == 0) return {};
        if (n == 1) return {new TreeNode(0)};

        vector<TreeNode*> res;
        for (int i = 1; i < n; i += 2) {
            vector<TreeNode*> leftTrees = allPossibleFBT(i);
            vector<TreeNode*> rightTrees = allPossibleFBT(n - i - 1);

            for (TreeNode* left : leftTrees) {
                for (TreeNode* right : rightTrees) {
                    TreeNode* root = new TreeNode(0);
                    root->left = left;
                    root->right = right;
                    res.push_back(root);
                }
            }
        }
        return res;
    }
};