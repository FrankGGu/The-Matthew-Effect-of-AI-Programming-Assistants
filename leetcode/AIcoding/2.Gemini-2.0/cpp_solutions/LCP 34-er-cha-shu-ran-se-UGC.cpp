#include <vector>
#include <queue>

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
    int btreeGameWinningMove(TreeNode* root, int n, int x) {
        TreeNode* x_node = findNode(root, x);
        int left_count = countNodes(x_node->left);
        int right_count = countNodes(x_node->right);
        int parent_count = n - 1 - left_count - right_count;

        return (left_count > n / 2 || right_count > n / 2 || parent_count > n / 2);
    }

private:
    TreeNode* findNode(TreeNode* root, int x) {
        if (!root) return nullptr;
        if (root->val == x) return root;
        TreeNode* left_result = findNode(root->left, x);
        if (left_result) return left_result;
        return findNode(root->right, x);
    }

    int countNodes(TreeNode* root) {
        if (!root) return 0;
        return 1 + countNodes(root->left) + countNodes(root->right);
    }
};