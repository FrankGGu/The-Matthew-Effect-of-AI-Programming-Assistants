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
    int maxProduct(TreeNode* root) {
        long total = 0;
        unordered_map<TreeNode*, long> subtreeSum;

        function<long(TreeNode*)> getSubtreeSum = [&](TreeNode* node) {
            if (!node) return 0L;
            long sum = node->val + getSubtreeSum(node->left) + getSubtreeSum(node->right);
            subtreeSum[node] = sum;
            return sum;
        };

        total = getSubtreeSum(root);

        long maxProd = 0;
        for (auto& [node, sum] : subtreeSum) {
            long remaining = total - sum;
            maxProd = max(maxProd, sum * remaining);
        }

        return static_cast<int>(maxProd % (1000000007));
    }
};