#include <vector>
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    void flatten(TreeNode* root) {
        if (!root) return;
        vector<TreeNode*> nodes;
        preOrderTraversal(root, nodes);
        for (int i = 0; i < nodes.size() - 1; i++) {
            nodes[i]->left = nullptr;
            nodes[i]->right = nodes[i + 1];
        }
    }

private:
    void preOrderTraversal(TreeNode* node, vector<TreeNode*>& nodes) {
        if (!node) return;
        nodes.push_back(node);
        preOrderTraversal(node->left, nodes);
        preOrderTraversal(node->right, nodes);
    }
};