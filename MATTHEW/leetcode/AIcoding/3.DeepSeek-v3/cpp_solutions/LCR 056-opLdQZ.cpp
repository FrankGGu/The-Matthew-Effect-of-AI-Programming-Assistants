#include <queue>
#include <unordered_set>
using namespace std;

class Solution {
public:
    bool findTarget(TreeNode* root, int k) {
        if (!root) return false;
        queue<TreeNode*> q;
        unordered_set<int> seen;
        q.push(root);
        while (!q.empty()) {
            TreeNode* node = q.front();
            q.pop();
            int complement = k - node->val;
            if (seen.count(complement)) {
                return true;
            }
            seen.insert(node->val);
            if (node->left) q.push(node->left);
            if (node->right) q.push(node->right);
        }
        return false;
    }
};