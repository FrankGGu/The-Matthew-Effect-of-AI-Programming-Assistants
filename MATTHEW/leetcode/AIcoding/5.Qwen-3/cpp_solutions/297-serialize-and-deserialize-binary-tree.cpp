#include <iostream>
#include <vector>
#include <string>
#include <sstream>
#include <queue>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
        string serialize(TreeNode* root) {
        ostringstream out;
        queue<TreeNode*> q;
        if (root) q.push(root);
        while (!q.empty()) {
            TreeNode* node = q.front();
            q.pop();
            if (node) {
                out << node->val << " ";
                q.push(node->left);
                q.push(node->right);
            } else {
                out << "null ";
            }
        }
        return out.str();
    }

        TreeNode* deserialize(string data) {
        if (data.empty()) return nullptr;
        istringstream in(data);
        string val;
        in >> val;
        TreeNode* root = new TreeNode(stoi(val));
        queue<TreeNode*> q;
        q.push(root);
        while (!q.empty()) {
            TreeNode* node = q.front();
            q.pop();
            if (in >> val) {
                if (val != "null") {
                    node->left = new TreeNode(stoi(val));
                    q.push(node->left);
                }
            }
            if (in >> val) {
                if (val != "null") {
                    node->right = new TreeNode(stoi(val));
                    q.push(node->right);
                }
            }
        }
        return root;
    }
};