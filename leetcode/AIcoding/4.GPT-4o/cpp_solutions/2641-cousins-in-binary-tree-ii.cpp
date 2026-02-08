#include <vector>
#include <queue>
using namespace std;

class TreeNode {
public:
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    vector<TreeNode*> findCousins(TreeNode* root, TreeNode* target) {
        if (!root) return {};
        queue<TreeNode*> q;
        q.push(root);
        bool found = false;
        vector<TreeNode*> cousins;

        while (!q.empty() && !found) {
            int size = q.size();
            cousins.clear();
            for (int i = 0; i < size; ++i) {
                TreeNode* node = q.front();
                q.pop();
                if (node->left) {
                    if (node->left == target) found = true;
                    else cousins.push_back(node->left);
                    q.push(node->left);
                }
                if (node->right) {
                    if (node->right == target) found = true;
                    else cousins.push_back(node->right);
                    q.push(node->right);
                }
            }
        }

        return found ? cousins : vector<TreeNode*>();
    }
};