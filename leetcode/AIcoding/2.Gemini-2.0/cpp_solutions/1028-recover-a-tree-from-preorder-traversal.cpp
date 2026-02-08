class Solution {
public:
    TreeNode* recoverFromPreorder(string traversal) {
        int pos = 0;
        return helper(traversal, pos, 0);
    }

    TreeNode* helper(string& traversal, int& pos, int depth) {
        int dashes = 0;
        while (pos + dashes < traversal.size() && traversal[pos + dashes] == '-') {
            dashes++;
        }
        if (dashes != depth) {
            return nullptr;
        }

        pos += dashes;
        int val = 0;
        while (pos < traversal.size() && isdigit(traversal[pos])) {
            val = val * 10 + (traversal[pos] - '0');
            pos++;
        }

        TreeNode* node = new TreeNode(val);
        node->left = helper(traversal, pos, depth + 1);
        node->right = helper(traversal, pos, depth + 1);

        return node;
    }
};