class BSTIterator {
private:
    std::stack<TreeNode*> s;

    void pushAllLeft(TreeNode* node) {
        while (node != nullptr) {
            s.push(node);
            node = node->left;
        }
    }

public:
    BSTIterator(TreeNode* root) {
        pushAllLeft(root);
    }

    int next() {
        TreeNode* topNode = s.top();
        s.pop();
        if (topNode->right != nullptr) {
            pushAllLeft(topNode->right);
        }
        return topNode->val;
    }

    bool hasNext() {
        return !s.empty();
    }
};