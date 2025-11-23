#include <vector>
#include <unordered_map>
#include <algorithm>
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    vector<int> findFrequentTreeSum(TreeNode* root) {
        unordered_map<int, int> sumCount;
        int maxFrequency = 0;
        vector<int> result;
        calculateSum(root, sumCount, maxFrequency);
        for (const auto& entry : sumCount) {
            if (entry.second == maxFrequency) {
                result.push_back(entry.first);
            }
        }
        return result;
    }

private:
    int calculateSum(TreeNode* node, unordered_map<int, int>& sumCount, int& maxFrequency) {
        if (!node) return 0;
        int sum = node->val + calculateSum(node->left, sumCount, maxFrequency) + calculateSum(node->right, sumCount, maxFrequency);
        sumCount[sum]++;
        maxFrequency = max(maxFrequency, sumCount[sum]);
        return sum;
    }
};