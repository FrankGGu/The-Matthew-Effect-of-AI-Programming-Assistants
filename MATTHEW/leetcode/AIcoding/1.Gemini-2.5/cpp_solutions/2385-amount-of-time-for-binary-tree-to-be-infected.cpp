#include <vector>
#include <queue>
#include <map>
#include <set>
#include <algorithm>

class Solution {
public:
    std::map<int, std::vector<int>> adj;

    void buildGraph(TreeNode* node, TreeNode* parent) {
        if (!node) {
            return;
        }

        if (parent) {
            adj[node->val].push_back(parent->val);
            adj[parent->val].push_back(node->val);
        }
        if (node->left) {
            adj[node->val].push_back(node->left->val);
            adj[node->left->val].push_back(node->val);
        }
        if (node->right) {
            adj[node->val].push_back(node->right->val);
            adj[node->right->val].push_back(node->val);
        }

        buildGraph(node->left, node);
        buildGraph(node->right, node);
    }

    int amountOfTime(TreeNode* root, int start) {
        buildGraph(root, nullptr);

        int maxTime = 0;
        std::queue<std::pair<int, int>> q;
        std::set<int> visited;

        q.push({start, 0});
        visited.insert(start);

        while (!q.empty()) {
            std::pair<int, int> current = q.front();
            q.pop();
            int node_val = current.first;
            int time = current.second;

            maxTime = std::max(maxTime, time);

            for (int neighbor : adj[node_val]) {
                if (visited.find(neighbor) == visited.end()) {
                    visited.insert(neighbor);
                    q.push({neighbor, time + 1});
                }
            }
        }

        return maxTime;
    }
};