class Solution {
public:
    vector<TreeNode*> findDuplicateSubtrees(TreeNode* root) {
        unordered_map<string, int> counts;
        vector<TreeNode*> result;
        serialize(root, counts, result);
        return result;
    }

private:
    string serialize(TreeNode* node, unordered_map<string, int>& counts, vector<TreeNode*>& result) {
        if (!node) {
            return "#";
        }

        string s = to_string(node->val) + "," + serialize(node->left, counts, result) + "," + serialize(node->right, counts, result);

        counts[s]++;

        if (counts[s] == 2) {
            result.push_back(node);
        }

        return s;
    }
};