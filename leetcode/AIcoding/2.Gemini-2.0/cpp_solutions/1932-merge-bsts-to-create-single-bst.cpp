class Solution {
public:
    TreeNode* canMerge(vector<TreeNode*>& trees) {
        unordered_map<int, TreeNode*> nodes;
        unordered_map<int, int> inDegree;

        for (TreeNode* root : trees) {
            nodes[root->val] = root;
            inDegree[root->val] = 0;
        }

        for (TreeNode* root : trees) {
            if (root->left) {
                inDegree[root->left->val]++;
            }
            if (root->right) {
                inDegree[root->right->val]++;
            }
        }

        TreeNode* root = nullptr;
        int rootCount = 0;
        for (auto const& [key, val] : nodes) {
            if (inDegree[key] == 0) {
                root = val;
                rootCount++;
            }
        }

        if (rootCount != 1) return nullptr;

        function<bool(TreeNode*, int, int)> isValidBST = [&](TreeNode* node, int minVal, int maxVal) {
            if (!node) return true;
            if (node->val <= minVal || node->val >= maxVal) return false;
            return isValidBST(node->left, minVal, node->val) && isValidBST(node->right, node->val, maxVal);
        };

        if (!isValidBST(root, INT_MIN, INT_MAX)) return nullptr;

        unordered_set<int> visited;
        function<void(TreeNode*)> dfs = [&](TreeNode* node) {
            if (!node) return;
            visited.insert(node->val);
            dfs(node->left);
            dfs(node->right);
        };

        dfs(root);

        if (visited.size() != nodes.size()) return nullptr;

        return root;
    }
};