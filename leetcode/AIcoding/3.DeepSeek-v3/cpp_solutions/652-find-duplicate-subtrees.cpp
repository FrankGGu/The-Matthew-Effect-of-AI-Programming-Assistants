class Solution {
public:
    vector<TreeNode*> findDuplicateSubtrees(TreeNode* root) {
        unordered_map<string, int> freq;
        vector<TreeNode*> result;
        serialize(root, freq, result);
        return result;
    }

private:
    string serialize(TreeNode* node, unordered_map<string, int>& freq, vector<TreeNode*>& result) {
        if (!node) return "#";
        string left = serialize(node->left, freq, result);
        string right = serialize(node->right, freq, result);
        string key = to_string(node->val) + "," + left + "," + right;
        if (++freq[key] == 2) {
            result.push_back(node);
        }
        return key;
    }
};