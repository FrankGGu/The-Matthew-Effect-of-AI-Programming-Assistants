class Solution {
public:
    int pathSum(TreeNode* root, int targetSum) {
        unordered_map<long, int> prefixSum;
        prefixSum[0] = 1;
        return dfs(root, 0, targetSum, prefixSum);
    }

private:
    int dfs(TreeNode* node, long currentSum, int targetSum, unordered_map<long, int>& prefixSum) {
        if (!node) return 0;

        currentSum += node->val;
        int res = prefixSum[currentSum - targetSum];

        prefixSum[currentSum]++;
        res += dfs(node->left, currentSum, targetSum, prefixSum) + dfs(node->right, currentSum, targetSum, prefixSum);
        prefixSum[currentSum]--;

        return res;
    }
};