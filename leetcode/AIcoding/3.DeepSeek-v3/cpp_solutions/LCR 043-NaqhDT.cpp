#include <queue>
using namespace std;

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
    queue<TreeNode*> candidate;

public:
    CBTInserter(TreeNode* root) {
        this->root = root;
        queue<TreeNode*> q;
        q.push(root);
        while (!q.empty()) {
            TreeNode* node = q.front();
            q.pop();
            if (node->left == nullptr || node->right == nullptr) {
                candidate.push(node);
            }
            if (node->left != nullptr) {
                q.push(node->left);
            }
            if (node->right != nullptr) {
                q.push(node->right);
            }
        }
    }

    int insert(int val) {
        TreeNode* newNode = new TreeNode(val);
        TreeNode* parent = candidate.front();
        if (parent->left == nullptr) {
            parent->left = newNode;
        } else {
            parent->right = newNode;
            candidate.pop();
        }
        candidate.push(newNode);
        return parent->val;
    }

    TreeNode* get_root() {
        return root;
    }
};