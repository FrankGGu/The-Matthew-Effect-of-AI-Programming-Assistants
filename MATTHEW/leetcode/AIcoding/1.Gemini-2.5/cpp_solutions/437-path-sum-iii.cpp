#include <map>

class Solution {
public:
    int pathSum(TreeNode* root, int targetSum) {
        std::map<long long, int> prefixSumCount;
        prefixSumCount[0] = 1; 
        int count = 0;
        dfs(root, 0, targetSum, prefixSumCount, count);
        return count;
    }

private:
    void dfs(TreeNode* node, long long currentPathSum, int targetSum, std::map<long long, int>& prefixSumCount, int& count) {
        if (node == nullptr) {
            return;
        }

        currentPathSum += node->val;

        long long complement = currentPathSum - targetSum;
        if (prefixSumCount.count(complement)) {
            count += prefixSumCount[complement];
        }

        prefixSumCount[currentPathSum]++;

        dfs(node->left, currentPathSum, targetSum, prefixSumCount, count);
        dfs(node->right, currentPathSum, targetSum, prefixSumCount, count);

        prefixSumCount[currentPathSum]--;
    }
};