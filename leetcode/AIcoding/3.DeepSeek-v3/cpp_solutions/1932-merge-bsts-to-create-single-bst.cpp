class Solution {
public:
    TreeNode* canMerge(vector<TreeNode*>& trees) {
        unordered_map<int, TreeNode*> valToRoot;
        unordered_map<int, int> count;

        for (auto tree : trees) {
            valToRoot[tree->val] = tree;
            count[tree->val]++;
            if (tree->left) count[tree->left->val]++;
            if (tree->right) count[tree->right->val]++;
        }

        TreeNode* root = nullptr;
        for (auto tree : trees) {
            if (count[tree->val] == 1) {
                root = tree;
                break;
            }
        }

        if (!root) return nullptr;

        unordered_set<int> seen;
        bool valid = true;

        valToRoot.erase(root->val);
        seen.insert(root->val);

        function<bool(TreeNode*, int, int)> dfs = [&](TreeNode* node, int min_val, int max_val) {
            if (!node) return true;
            if (node->val <= min_val || node->val >= max_val) return false;

            if (!node->left && !node->right) {
                auto it = valToRoot.find(node->val);
                if (it != valToRoot.end()) {
                    node->left = it->second->left;
                    node->right = it->second->right;
                    valToRoot.erase(it);
                }
            }

            if (seen.count(node->val)) return false;
            seen.insert(node->val);

            return dfs(node->left, min_val, node->val) && dfs(node->right, node->val, max_val);
        };

        if (!dfs(root, INT_MIN, INT_MAX) || !valToRoot.empty()) {
            return nullptr;
        }

        return root;
    }
};