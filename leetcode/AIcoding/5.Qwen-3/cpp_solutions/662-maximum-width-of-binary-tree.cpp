#include <iostream>
#include <vector>
#include <queue>
#include <utility>

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

        int maxWidth = 0;
        queue<pair<TreeNode*, int>> q;
        q.push({root, 0});

        while (!q.empty()) {
            int levelSize = q.size();
            int levelStart = q.front().second;
            int levelEnd = 0;

            for (int i = 0; i < levelSize; ++i) {
                auto [node, index] = q.front();
                q.pop();
                levelEnd = index;

                if (node->left) {
                    q.push({node->left, static_cast<long long>(index) * 2 + 1});
                }
                if (node->right) {
                    q.push({node->right, static_cast<long long>(index) * 2 + 2});
                }
            }

            maxWidth = max(maxWidth, levelEnd - levelStart + 1);
        }

        return maxWidth;
    }
};