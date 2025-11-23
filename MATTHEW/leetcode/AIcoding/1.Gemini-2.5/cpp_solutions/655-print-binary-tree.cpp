#include <vector>
#include <string>
#include <algorithm> // For std::max

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
    int getHeight(TreeNode* root) {
        if (!root) {
            return -1;
        }
        return 1 + std::max(getHeight(root->left), getHeight(root->right));
    }

    void fillMatrix(TreeNode* node, int row, int col, int totalHeight, std::vector<std::vector<std::string>>& matrix) {
        if (!node) {
            return;
        }

        matrix[row][col] = std::to_string(node->val);

        int offset = 1 << (totalHeight - row - 1);

        if (node->left) {
            fillMatrix(node->left, row + 1, col - offset, totalHeight, matrix);
        }
        if (node->right) {
            fillMatrix(node->right, row + 1, col + offset, totalHeight, matrix);
        }
    }

    std::vector<std::vector<std::string>> printTree(TreeNode* root) {
        int h = getHeight(root);
        int m = h + 1;
        int n = (1 << (h + 1)) - 1;

        std::vector<std::vector<std::string>> result(m, std::vector<std::string>(n, ""));

        if (!root) {
            return result;
        }

        fillMatrix(root, 0, (n - 1) / 2, h, result);

        return result;
    }
};