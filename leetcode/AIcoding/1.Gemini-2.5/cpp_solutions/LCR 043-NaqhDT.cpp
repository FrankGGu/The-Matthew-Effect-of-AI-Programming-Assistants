#include <deque> // Required for std::deque

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
    std::deque<TreeNode*> q;

public:
    CBTInserter(TreeNode* root) {
        root_node = root;
        if (!root) {
            return;
        }

        std::deque<TreeNode*> temp_q;
        temp_q.push_back(root);

        while (!temp_q.empty()) {
            TreeNode* node = temp_q.front();
            temp_q.pop_front();

            if (node->left == nullptr || node->right == nullptr) {
                q.push_back(node);
            }

            if (node->left) {
                temp_q.push_back(node->left);
            }
            if (node->right) {
                temp_q.push_back(node->right);
            }
        }
    }

    int insert(int val) {
        TreeNode* newNode = new TreeNode(val);
        TreeNode* parent = q.front();

        if (parent->left == nullptr) {
            parent->left = newNode;
        } else {
            parent->right = newNode;
            q.pop_front();
        }

        q.push_back(newNode);
        return parent->val;
    }

    TreeNode* get_root() {
        return root_node;
    }
};