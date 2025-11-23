#include <unordered_map>

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
public:
    int pathSum(TreeNode* root, int targetSum) {
        prefixSumCount[0] = 1;
        dfs(root, 0, targetSum);
        return count;
    }

private:
    std::unordered_map<long long, int> prefixSumCount;
    int count = 0;

    void dfs(TreeNode* node, long long currentSum, int targetSum) {
        if (!node) {
            return;
        }

        currentSum += node->val;

        if (prefixSumCount.count(currentSum - targetSum)) {
            count += prefixSumCount[currentSum - targetSum];
        }

        prefixSumCount[currentSum]++;

        dfs(node->left, currentSum, targetSum);
        dfs(node->right, currentSum, targetSum);

        prefixSumCount[currentSum]--;
    }
};