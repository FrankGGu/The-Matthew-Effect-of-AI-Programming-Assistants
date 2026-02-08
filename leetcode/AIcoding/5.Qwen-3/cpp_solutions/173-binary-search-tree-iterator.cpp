#include <iostream>
#include <vector>
#include <stack>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
private:
    stack<TreeNode*> nodes;
    bool reverse = false;

    void pushAll(TreeNode* node) {
        while (node != NULL) {
            nodes.push(node);
            if (reverse) {
                node = node->right;
            } else {
                node = node->left;
            }
        }
    }

public:
    Solution(TreeNode* root, bool isReverse = false) {
        reverse = isReverse;
        pushAll(root);
    }

    int next() {
        TreeNode* node = nodes.top();
        nodes.pop();
        if (!reverse) {
            pushAll(node->right);
        } else {
            pushAll(node->left);
        }
        return node->val;
    }

    bool hasNext() {
        return !nodes.empty();
    }
};