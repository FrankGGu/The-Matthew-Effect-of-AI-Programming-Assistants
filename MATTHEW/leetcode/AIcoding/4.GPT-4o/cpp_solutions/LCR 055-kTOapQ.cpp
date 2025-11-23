class BSTIterator {
public:
    stack<TreeNode*> stk;

    BSTIterator(TreeNode* root) {
        pushAll(root);
    }

    int next() {
        TreeNode* node = stk.top();
        stk.pop();
        pushAll(node->right);
        return node->val;
    }

    bool hasNext() {
        return !stk.empty();
    }

private:
    void pushAll(TreeNode* node) {
        for (; node != nullptr; stk.push(node), node = node->left);
    }
};