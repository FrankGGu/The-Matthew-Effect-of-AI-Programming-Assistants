#include <queue>
#include <climits> // Required for INT_MIN and INT_MAX

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
    bool isEvenOddTree(TreeNode* root) {
        if (!root) {
            return true;
        }

        std::queue<TreeNode*> q;
        q.push(root);
        int level = 0;

        while (!q.empty()) {
            int level_size = q.size();
            int prev_val;

            if (level % 2 == 0) { // Even level: odd values, strictly increasing
                prev_val = INT_MIN; // Smallest possible value to ensure first node is greater
            } else { // Odd level: even values, strictly decreasing
                prev_val = INT_MAX; // Largest possible value to ensure first node is smaller
            }

            for (int i = 0; i < level_size; ++i) {
                TreeNode* curr = q.front();
                q.pop();

                if (level % 2 == 0) { // Even level (0, 2, 4, ...)
                    // Condition 1: Every node at an even level has odd integer values.
                    if (curr->val % 2 == 0) {
                        return false;
                    }
                    // Condition 3: Every node at an even level has values in strictly increasing order from left to right.
                    if (curr->val <= prev_val) {
                        return false;
                    }
                } else { // Odd level (1, 3, 5, ...)
                    // Condition 2: Every node at an odd level has even integer values.
                    if (curr->val % 2 != 0) {
                        return false;
                    }
                    // Condition 4: Every node at an odd level has values in strictly decreasing order from left to right.
                    if (curr->val >= prev_val) {
                        return false;
                    }
                }
                prev_val = curr->val;

                if (curr->left) {
                    q.push(curr->left);
                }
                if (curr->right) {
                    q.push(curr->right);
                }
            }
            level++;
        }

        return true;
    }
};