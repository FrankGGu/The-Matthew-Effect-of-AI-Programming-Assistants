class Solution {
public:
    void recoverTree(TreeNode* root) {
        TreeNode *first = nullptr, *second = nullptr, *prev = nullptr;
        TreeNode *current = root;
        stack<TreeNode*> st;

        while (current || !st.empty()) {
            while (current) {
                st.push(current);
                current = current->left;
            }
            current = st.top();
            st.pop();

            if (prev && prev->val > current->val) {
                if (!first) {
                    first = prev;
                }
                second = current;
            }
            prev = current;
            current = current->right;
        }

        if (first && second) {
            swap(first->val, second->val);
        }
    }
};