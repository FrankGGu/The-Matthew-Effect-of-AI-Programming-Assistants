#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    vector<TreeNode*> getAllNodes(TreeNode* root) {
        vector<TreeNode*> nodes;
        if (!root) return nodes;
        nodes.push_back(root);
        vector<TreeNode*> left = getAllNodes(root->left);
        vector<TreeNode*> right = getAllNodes(root->right);
        nodes.insert(nodes.end(), left.begin(), left.end());
        nodes.insert(nodes.end(), right.begin(), right.end());
        return nodes;
    }

    TreeNode* mergeBSTs(vector<TreeNode*>& trees) {
        if (trees.empty()) return nullptr;
        vector<TreeNode*> allNodes;
        for (TreeNode* tree : trees) {
            vector<TreeNode*> nodes = getAllNodes(tree);
            allNodes.insert(allNodes.end(), nodes.begin(), nodes.end());
        }
        sort(allNodes.begin(), allNodes.end(), [](TreeNode* a, TreeNode* b) { return a->val < b->val; });
        if (allNodes.empty()) return nullptr;
        TreeNode* root = new TreeNode(allNodes[0]->val);
        for (int i = 1; i < allNodes.size(); ++i) {
            TreeNode* node = root;
            while (true) {
                if (allNodes[i]->val < node->val) {
                    if (node->left) {
                        node = node->left;
                    } else {
                        node->left = allNodes[i];
                        break;
                    }
                } else {
                    if (node->right) {
                        node = node->right;
                    } else {
                        node->right = allNodes[i];
                        break;
                    }
                }
            }
        }
        return root;
    }
};