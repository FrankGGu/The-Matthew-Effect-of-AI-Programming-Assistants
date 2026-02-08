class BSTIterator {
private:
    stack<TreeNode*> st;

    void pushAll(TreeNode* node) {
        while (node) {
            st.push(node);
            node = node->left;
        }
    }

public:
    BSTIterator(TreeNode* root) {
        pushAll(root);
    }

    int next() {
        TreeNode* node = st.top();
        st.pop();
        pushAll(node->right);
        return node->val;
    }

    bool hasNext() {
        return !st.empty();
    }
};