class Solution {
public:
    int goodNodes(TreeNode* root) {
        return goodNodesHelper(root, root->val);
    }

private:
    int goodNodesHelper(TreeNode* root, int maxVal) {
        if (!root) return 0;

        int count = 0;
        if (root->val >= maxVal) {
            count++;
            maxVal = root->val;
        }

        count += goodNodesHelper(root->left, maxVal);
        count += goodNodesHelper(root->right, maxVal);

        return count;
    }
};