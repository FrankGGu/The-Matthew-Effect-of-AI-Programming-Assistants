#include <queue>

class CBTInserter {
public:
    struct TreeNode {
        int val;
        TreeNode *left;
        TreeNode *right;
        TreeNode(int x) : val(x), left(NULL), right(NULL) {}
    };

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
        TreeNode* newNode = new TreeNode(v);
        if (!q.front()->left) {
            q.front()->left = newNode;
        } else {
            q.front()->right = newNode;
            q.pop();
        }
        q.push(newNode);
        return q.front()->val;
    }

    TreeNode* get_root() {
        return root;
    }
};