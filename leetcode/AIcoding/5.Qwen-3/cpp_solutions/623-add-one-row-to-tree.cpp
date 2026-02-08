#include <iostream>
#include <vector>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
public:
    TreeNode* addOneRow(TreeNode* root, int val, int depth) {
        if (depth == 1) {
            TreeNode* newRoot = new TreeNode(val);
            newRoot->left = root;
            return newRoot;
        }

        int currentDepth = 1;
        vector<TreeNode*> queue;
        queue.push_back(root);

        while (!queue.empty() && currentDepth < depth - 1) {
            int size = queue.size();
            for (int i = 0; i < size; ++i) {
                TreeNode* node = queue[i];
                if (node->left) queue.push_back(node->left);
                if (node->right) queue.push_back(node->right);
            }
            queue.erase(queue.begin(), queue.begin() + size);
            currentDepth++;
        }

        for (TreeNode* node : queue) {
            TreeNode* left = node->left;
            TreeNode* right = node->right;
            node->left = new TreeNode(val);
            node->right = new TreeNode(val);
            node->left->left = left;
            node->right->right = right;
        }

        return root;
    }
};