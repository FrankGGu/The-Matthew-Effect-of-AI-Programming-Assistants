class Solution {
public:
    TreeNode* lowestCommonAncestor(TreeNode* root, int p, int q) {
        if (!root || root->val == p || root->val == q) {
            return root;
        }

        TreeNode* left = lowestCommonAncestor(root->left, p, q);
        TreeNode* right = lowestCommonAncestor(root->right, p, q);

        if (left && right) {
            return root;
        }
        return left ? left : right;
    }

    bool findPath(TreeNode* node, int target, std::string& path) {
        if (!node) {
            return false;
        }
        if (node->val == target) {
            return true;
        }

        path.push_back('L');
        if (findPath(node->left, target, path)) {
            return true;
        }
        path.pop_back();

        path.push_back('R');
        if (findPath(node->right, target, path)) {
            return true;
        }
        path.pop_back();

        return false;
    }

    string getDirections(TreeNode* root, int startValue, int destValue) {
        TreeNode* lca = lowestCommonAncestor(root, startValue, destValue);

        std::string pathToStart;
        findPath(lca, startValue, pathToStart);

        std::string pathToDest;
        findPath(lca, destValue, pathToDest);

        std::string result = "";
        for (char c : pathToStart) {
            result += 'U';
        }
        result += pathToDest;

        return result;
    }
};