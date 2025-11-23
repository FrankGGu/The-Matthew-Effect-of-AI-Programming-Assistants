class Solution {
public:
    TreeNode* increasingBST(TreeNode* root) {
        TreeNode* dummy = new TreeNode(0);
        TreeNode* cur = dummy;
        stack<TreeNode*> st;
        TreeNode* node = root;
        while (node || !st.empty()) {
            while (node) {
                st.push(node);
                node = node->left;
            }
            node = st.top();
            st.pop();
            cur->right = node;
            node->left = nullptr;
            cur = node;
            node = node->right;
        }
        return dummy->right;
    }
};