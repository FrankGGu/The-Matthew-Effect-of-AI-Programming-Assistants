#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int amountOfTime(TreeNode* root, int start) {
        unordered_map<TreeNode*, TreeNode*> parentMap;
        queue<TreeNode*> q;
        q.push(root);
        TreeNode* startNode = nullptr;

        while (!q.empty()) {
            TreeNode* node = q.front();
            q.pop();
            if (node->val == start) {
                startNode = node;
            }
            if (node->left) {
                parentMap[node->left] = node;
                q.push(node->left);
            }
            if (node->right) {
                parentMap[node->right] = node;
                q.push(node->right);
            }
        }

        queue<TreeNode*> infectQ;
        infectQ.push(startNode);
        unordered_map<TreeNode*, bool> visited;
        visited[startNode] = true;
        int time = 0;

        while (!infectQ.empty()) {
            int size = infectQ.size();
            for (int i = 0; i < size; ++i) {
                TreeNode* current = infectQ.front();
                infectQ.pop();
                if (current->left && !visited[current->left]) {
                    visited[current->left] = true;
                    infectQ.push(current->left);
                }
                if (current->right && !visited[current->right]) {
                    visited[current->right] = true;
                    infectQ.push(current->right);
                }
                if (parentMap.find(current) != parentMap.end() && !visited[parentMap[current]]) {
                    visited[parentMap[current]] = true;
                    infectQ.push(parentMap[current]);
                }
            }
            time++;
        }

        return time - 1;
    }
};