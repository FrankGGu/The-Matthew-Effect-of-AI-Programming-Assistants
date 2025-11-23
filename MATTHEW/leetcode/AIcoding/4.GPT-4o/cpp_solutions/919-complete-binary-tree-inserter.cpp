#include <queue>

class CBTInserter {
public:
    TreeNode* root;
    std::queue<TreeNode*> q;

    CBTInserter(TreeNode* root) {
        this->root = root;
        q.push(root);
        while (q.front()->left && q.front()->right) {
            q.push(q.front()->left);
            q.push(q.front()->right);
            q.pop();
        }
    }

    int insert(int v) {
        TreeNode* node = new TreeNode(v);
        if (!q.front()->left) {
            q.front()->left = node;
        } else {
            q.front()->right = node;
            q.pop();
        }
        q.push(node);
        return q.front()->val;
    }

    TreeNode* get_root() {
        return root;
    }
};