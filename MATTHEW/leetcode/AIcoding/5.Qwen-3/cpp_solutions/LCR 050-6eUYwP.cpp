#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    int pathSum(TreeNode* root, int targetSum) {
        unordered_map<long long, int> prefixSumCount;
        prefixSumCount[0] = 1;
        return dfs(root, targetSum, 0, prefixSumCount);
    }

private:
    int dfs(TreeNode* node, int targetSum, long long currentSum, unordered_map<long long, int>& prefixSumCount) {
        if (!node) {
            return 0;
        }

        currentSum += node->val;
        int count = 0;

        if (prefixSumCount.find(currentSum - targetSum) != prefixSumCount.end()) {
            count += prefixSumCount[currentSum - targetSum];
        }

        prefixSumCount[currentSum]++;

        count += dfs(node->left, targetSum, currentSum, prefixSumCount);
        count += dfs(node->right, targetSum, currentSum, prefixSumCount);

        prefixSumCount[currentSum]--;
        return count;
    }
};