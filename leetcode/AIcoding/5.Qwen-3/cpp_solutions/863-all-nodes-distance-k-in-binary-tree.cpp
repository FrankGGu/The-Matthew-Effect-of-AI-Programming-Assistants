#include <iostream>
#include <vector>
#include <unordered_map>
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
    vector<int> distanceK(TreeNode* root, TreeNode* target, int k) {
        vector<int> result;
        unordered_map<TreeNode*, TreeNode*> parentMap;
        queue<TreeNode*> q;
        q.push(root);

        while (!q.empty()) {
            TreeNode* node = q.front();
            q.pop();
            if (node->left) {
                parentMap[node->left] = node;
                q.push(node->left);
            }
            if (node->right) {
                parentMap[node->right] = node;
                q.push(node->right);
            }
        }

        unordered_map<TreeNode*, bool> visited;
        queue<pair<TreeNode*, int>> nodeQueue;
        nodeQueue.push({target, 0});
        visited[target] = true;

        while (!nodeQueue.empty()) {
            auto [current, dist] = nodeQueue.front();
            nodeQueue.pop();

            if (dist == k) {
                result.push_back(current->val);
                continue;
            }

            if (current->left && !visited[current->left]) {
                visited[current->left] = true;
                nodeQueue.push({current->left, dist + 1});
            }
            if (current->right && !visited[current->right]) {
                visited[current->right] = true;
                nodeQueue.push({current->right, dist + 1});
            }
            if (parentMap.find(current) != parentMap.end() && !visited[parentMap[current]]) {
                visited[parentMap[current]] = true;
                nodeQueue.push({parentMap[current], dist + 1});
            }
        }

        return result;
    }
};