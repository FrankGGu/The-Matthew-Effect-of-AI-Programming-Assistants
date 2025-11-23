#include <iostream>
#include <vector>
#include <queue>
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
    int widthOfBinaryTree(TreeNode* root) {
        if (!root) return 0;
        queue<pair<TreeNode*, int>> q;
        q.push({root, 0});
        int max_width = 0;
        while (!q.empty()) {
            int level_size = q.size();
            int level_start = q.front().second;
            for (int i = 0; i < level_size; ++i) {
                auto [node, index] = q.front();
                q.pop();
                if (node->left) q.push({node->left, index * 2});
                if (node->right) q.push({node->right, index * 2 + 1});
            }
            max_width = max(max_width, q.back().second - level_start + 1);
        }
        return max_width;
    }
};