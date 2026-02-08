#include <queue>
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

int widthOfBinaryTree(TreeNode* root) {
    if (!root) return 0;
    queue<pair<TreeNode*, unsigned long long>> q;
    q.push({root, 0});
    int maxWidth = 0;

    while (!q.empty()) {
        int size = q.size();
        unsigned long long start = q.front().second;
        unsigned long long end = 0;

        for (int i = 0; i < size; ++i) {
            TreeNode* node = q.front().first;
            unsigned long long index = q.front().second;
            q.pop();

            if (i == size - 1) {
                end = index;
            }

            if (node->left) {
                q.push({node->left, 2 * index});
            }
            if (node->right) {
                q.push({node->right, 2 * index + 1});
            }
        }

        maxWidth = max(maxWidth, (int)(end - start + 1));
    }

    return maxWidth;
}