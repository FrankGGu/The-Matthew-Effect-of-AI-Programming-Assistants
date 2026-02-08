class Solution {
private:
    int max_zigzag_len = 0;

    void dfs(TreeNode* node, bool is_last_move_left, int current_len) {
        if (!node) {
            return;
        }

        max_zigzag_len = std::max(max_zigzag_len, current_len);

        if (is_last_move_left) { 
            // The path arrived at 'node' from its parent's left child.
            // To continue the zigzag path, the next move must be to the right.
            dfs(node->right, false, current_len + 1);
            // To start a new zigzag path from 'node', going left.
            // This new path starts from 'node->left', so the conceptual "previous move" to 'node->left'
            // from 'node' is a left move.
            dfs(node->left, true, 1);
        } else { 
            // The path arrived at 'node' from its parent's right child.
            // To continue the zigzag path, the next move must be to the left.
            dfs(node->left, true, current_len + 1);
            // To start a new zigzag path from 'node', going right.
            // This new path starts from 'node->right', so the conceptual "previous move" to 'node->right'
            // from 'node' is a right move.
            dfs(node->right, false, 1);
        }
    }

public:
    int longestZigZag(TreeNode* root) {
        if (!root) {
            return 0;
        }

        // Paths can start from the root, going either left or right.
        // For a path starting by going left from root to root->left:
        // When we are at root->left, the move to get there was a left move.
        dfs(root->left, true, 1);

        // For a path starting by going right from root to root->right:
        // When we are at root->right, the move to get there was a right move.
        dfs(root->right, false, 1);

        return max_zigzag_len;
    }
};