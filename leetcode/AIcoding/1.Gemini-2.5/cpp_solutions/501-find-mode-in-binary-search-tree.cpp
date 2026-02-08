#include <vector>
#include <algorithm>
#include <climits>

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
private:
    int current_val;
    int current_count;
    int max_count;
    std::vector<int> modes;

    void inorder_traverse(TreeNode* node, bool is_pass1) {
        if (!node) {
            return;
        }

        inorder_traverse(node->left, is_pass1);

        if (node->val == current_val) {
            current_count++;
        } else {
            current_val = node->val;
            current_count = 1;
        }

        if (is_pass1) {
            max_count = std::max(max_count, current_count);
        } else {
            if (current_count == max_count) {
                modes.push_back(node->val);
            }
        }

        inorder_traverse(node->right, is_pass1);
    }

public:
    std::vector<int> findMode(TreeNode* root) {
        if (!root) {
            return {};
        }

        current_val = INT_MIN;
        current_count = 0;
        max_count = 0;
        modes.clear();

        inorder_traverse(root, true);

        current_val = INT_MIN; 
        current_count = 0;
        modes.clear();

        inorder_traverse(root, false);

        return modes;
    }
};