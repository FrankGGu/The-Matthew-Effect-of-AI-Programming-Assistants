#include <stack>

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class BSTIterator {
private:
    std::stack<TreeNode*> s;

    void pushAllLeft(TreeNode* node) {
        while (node) {
            s.push(node);
            node = node->left;
        }
    }

public:
    BSTIterator(TreeNode* root) {
        pushAllLeft(root);
    }

    int next() {
        TreeNode* current = s.top();
        s.pop();
        if (current->right) {
            pushAllLeft(current->right);
        }
        return current->val;
    }

    bool hasNext() {
        return !s.empty();
    }
};