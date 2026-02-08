#include <vector>
#include <queue>
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
    int widthOfBinaryTree(TreeNode* root) {
        if (!root) return 0;
        queue<pair<TreeNode*, unsigned long long>> q;
        q.push({root, 0});
        unsigned long long maxWidth = 0;

        while (!q.empty()) {
            int size = q.size();
            unsigned long long leftmost = q.front().second, rightmost = q.back().second;
            maxWidth = max(maxWidth, rightmost - leftmost + 1);

            for (int i = 0; i < size; i++) {
                auto [node, idx] = q.front();
                q.pop();
                if (node->left) q.push({node->left, 2 * idx});
                if (node->right) q.push({node->right, 2 * idx + 1});
            }
        }
        return maxWidth;
    }
};