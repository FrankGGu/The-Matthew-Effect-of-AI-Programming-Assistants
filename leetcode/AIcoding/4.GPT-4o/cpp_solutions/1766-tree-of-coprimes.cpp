#include <vector>
#include <unordered_set>
#include <unordered_map>
#include <queue>
#include <algorithm>
#include <numeric>

using namespace std;

class Solution {
public:
    vector<vector<int>> getCoprimes(TreeNode* root, vector<int>& nums) {
        vector<vector<int>> result;
        unordered_map<int, vector<int>> graph;
        buildGraph(root, graph);

        vector<int> parents(1001, -1);
        vector<int> coprime(1001, -1);
        queue<TreeNode*> q;
        q.push(root);
        parents[root->val] = root->val;

        while (!q.empty()) {
            TreeNode* node = q.front();
            q.pop();
            int currentCoprime = -1;
            for (int i = 1; i <= 1000; i++) {
                if (coprime[i] == -1 && gcd(nums[node->val], i) == 1) {
                    currentCoprime = i;
                }
            }
            coprime[node->val] = currentCoprime;

            if (currentCoprime != -1) {
                result[currentCoprime].push_back(node->val);
            }

            for (auto& neighbor : graph[node->val]) {
                if (parents[neighbor] == -1) {
                    parents[neighbor] = node->val;
                    q.push(neighbor);
                }
            }
        }
        return result;
    }

private:
    void buildGraph(TreeNode* node, unordered_map<int, vector<int>>& graph) {
        if (!node) return;
        if (node->left) {
            graph[node->val].push_back(node->left->val);
            graph[node->left->val].push_back(node->val);
            buildGraph(node->left, graph);
        }
        if (node->right) {
            graph[node->val].push_back(node->right->val);
            graph[node->right->val].push_back(node->val);
            buildGraph(node->right, graph);
        }
    }
};