class Solution {
public:
    vector<int> smallestMissingValue(TreeNode* root) {
        vector<int> result;
        unordered_set<int> values;
        dfs(root, values, result);
        return result;
    }

    void dfs(TreeNode* node, unordered_set<int>& values, vector<int>& result) {
        if (!node) return;

        values.insert(node->val);
        dfs(node->left, values, result);
        dfs(node->right, values, result);

        int missing = 1;
        while (values.count(missing)) {
            missing++;
        }
        result.push_back(missing);
    }
};