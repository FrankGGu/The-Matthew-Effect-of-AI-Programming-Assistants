#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    vector<int> findFrequentTreeSum(TreeNode* root) {
        unordered_map<int, int> sumCount;
        int maxFreq = 0;
        vector<int> result;

        function<int(TreeNode*)> dfs = [&](TreeNode* node) -> int {
            if (!node) return 0;
            int left = dfs(node->left);
            int right = dfs(node->right);
            int currentSum = left + right + node->val;
            sumCount[currentSum]++;
            maxFreq = max(maxFreq, sumCount[currentSum]);
            return currentSum;
        };

        dfs(root);

        for (const auto& pair : sumCount) {
            if (pair.second == maxFreq) {
                result.push_back(pair.first);
            }
        }

        return result;
    }
};