#include <iostream>
#include <vector>
#include <climits>
#include <algorithm>

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
    vector<vector<int>> closestNodes(TreeNode* root, vector<int>& queries) {
        vector<int> inOrder;
        function<void(TreeNode*)> dfs = [&](TreeNode* node) {
            if (!node) return;
            dfs(node->left);
            inOrder.push_back(node->val);
            dfs(node->right);
        };
        dfs(root);

        vector<vector<int>> result;
        for (int q : queries) {
            int left = -1, right = -1;
            int l = 0, r = inOrder.size() - 1;
            while (l <= r) {
                int mid = l + (r - l) / 2;
                if (inOrder[mid] < q) {
                    l = mid + 1;
                } else {
                    r = mid - 1;
                }
            }
            if (l < inOrder.size()) right = inOrder[l];
            if (l > 0) left = inOrder[l - 1];
            result.push_back({left, right});
        }
        return result;
    }
};