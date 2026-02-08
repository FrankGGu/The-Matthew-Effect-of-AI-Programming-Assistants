class Solution {
public:
    int countPaths(TreeNode* root, int target) {
        unordered_map<int, int> prefix;
        prefix[0] = 1;
        int result = 0;
        dfs(root, 0, target, prefix, result);
        return result;
    }

    void dfs(TreeNode* node, int current_xor, int target, unordered_map<int, int>& prefix, int& result) {
        if (!node) return;

        current_xor ^= node->val;
        result += prefix[current_xor ^ target];
        prefix[current_xor]++;

        dfs(node->left, current_xor, target, prefix, result);
        dfs(node->right, current_xor, target, prefix, result);

        prefix[current_xor]--;
    }
};