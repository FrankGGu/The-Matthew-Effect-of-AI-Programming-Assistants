#include <queue>

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class CBTInserter {
private:
    TreeNode* root;
    std::queue<TreeNode*> q;

public:
    CBTInserter(TreeNode* root) {
        this->root = root;
        std::queue<TreeNode*> tmp;
        tmp.push(root);

        while (!tmp.empty()) {
            TreeNode* node = tmp.front();
            tmp.pop();

            if (node->left) {
                tmp.push(node->left);
            }
            if (node->right) {
                tmp.push(node->right);
            }

            if (!node->left || !node->right) {
                q.push(node);
            }
        }
    }

    int insert(int val) {
        TreeNode* node = new TreeNode(val);
        TreeNode* parent = q.front();

        if (!parent->left) {
            parent->left = node;
        } else {
            parent->right = node;
            q.pop();
        }

        q.push(node);
        return parent->val;
    }

    TreeNode* get_root() {
        return root;
    }
};