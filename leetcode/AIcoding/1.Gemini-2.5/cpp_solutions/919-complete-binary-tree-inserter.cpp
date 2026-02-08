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
    TreeNode* root_node;
    std::queue<TreeNode*> q;

public:
    CBTInserter(TreeNode* root) {
        root_node = root;
        std::queue<TreeNode*> bfs_q;
        bfs_q.push(root);

        while (!bfs_q.empty()) {
            TreeNode* curr = bfs_q.front();
            bfs_q.pop();

            if (curr->left == nullptr || curr->right == nullptr) {
                q.push(curr);
            }

            if (curr->left != nullptr) {
                bfs_q.push(curr->left);
            }
            if (curr->right != nullptr) {
                bfs_q.push(curr->right);
            }
        }
    }

    int insert(int val) {
        TreeNode* parent = q.front();
        TreeNode* newNode = new TreeNode(val);

        if (parent->left == nullptr) {
            parent->left = newNode;
        } else {
            parent->right = newNode;
            q.pop();
        }

        q.push(newNode);

        return parent->val;
    }

    TreeNode* get_root() {
        return root_node;
    }
};