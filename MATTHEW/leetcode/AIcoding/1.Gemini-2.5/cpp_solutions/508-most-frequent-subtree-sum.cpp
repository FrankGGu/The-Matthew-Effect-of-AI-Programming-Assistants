#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

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
    vector<int> findFrequentTreeSum(TreeNode* root) {
        unordered_map<int, int> sum_counts;
        int max_count = 0;

        function<int(TreeNode*)> subtree_sum = [&](TreeNode* node) {
            if (!node) return 0;

            int left_sum = subtree_sum(node->left);
            int right_sum = subtree_sum(node->right);
            int current_sum = node->val + left_sum + right_sum;

            sum_counts[current_sum]++;
            max_count = max(max_count, sum_counts[current_sum]);

            return current_sum;
        };

        subtree_sum(root);

        vector<int> result;
        for (auto const& [sum, count] : sum_counts) {
            if (count == max_count) {
                result.push_back(sum);
            }
        }

        return result;
    }
};