#include <unordered_map>
#include <queue>
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    int amountOfTime(TreeNode* root, int start) {
        unordered_map<int, TreeNode*> parent;
        queue<TreeNode*> q;
        q.push(root);
        while (!q.empty()) {
            TreeNode* node = q.front();
            q.pop();
            if (node->left) {
                parent[node->left->val] = node;
                q.push(node->left);
            }
            if (node->right) {
                parent[node->right->val] = node;
                q.push(node->right);
            }
        }

        q.push(findNode(root, start));
        unordered_map<int, bool> visited;
        visited[start] = true;
        int time = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; i++) {
                TreeNode* node = q.front();
                q.pop();
                if (node->left && !visited[node->left->val]) {
                    visited[node->left->val] = true;
                    q.push(node->left);
                }
                if (node->right && !visited[node->right->val]) {
                    visited[node->right->val] = true;
                    q.push(node->right);
                }
                if (parent[node->val] && !visited[parent[node->val]->val]) {
                    visited[parent[node->val]->val] = true;
                    q.push(parent[node->val]);
                }
            }
            time++;
        }
        return time - 1;
    }

private:
    TreeNode* findNode(TreeNode* root, int start) {
        if (!root) return nullptr;
        if (root->val == start) return root;
        TreeNode* left = findNode(root->left, start);
        if (left) return left;
        return findNode(root->right, start);
    }
};