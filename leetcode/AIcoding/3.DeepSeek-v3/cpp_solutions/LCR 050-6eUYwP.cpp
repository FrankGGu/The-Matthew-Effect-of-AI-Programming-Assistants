class Solution {
public:
    int pathSum(TreeNode* root, int targetSum) {
        unordered_map<long, int> prefixSum;
        prefixSum[0] = 1;
        return dfs(root, targetSum, 0, prefixSum);
    }

private:
    int dfs(TreeNode* node, int targetSum, long currSum, unordered_map<long, int>& prefixSum) {
        if (!node) return 0;

        currSum += node->val;
        int count = prefixSum[currSum - targetSum];

        prefixSum[currSum]++;
        count += dfs(node->left, targetSum, currSum, prefixSum);
        count += dfs(node->right, targetSum, currSum, prefixSum);
        prefixSum[currSum]--;

        return count;
    }
};