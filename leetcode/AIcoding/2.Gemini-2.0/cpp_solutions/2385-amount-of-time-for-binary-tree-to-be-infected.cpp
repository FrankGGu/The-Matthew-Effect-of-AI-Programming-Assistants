#include <vector>
#include <queue>
#include <unordered_map>

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
    int amountOfTime(TreeNode* root, int start) {
        unordered_map<int, vector<int>> adj;
        queue<TreeNode*> q;
        q.push(root);

        while (!q.empty()) {
            TreeNode* node = q.front();
            q.pop();

            if (node->left) {
                adj[node->val].push_back(node->left->val);
                adj[node->left->val].push_back(node->val);
                q.push(node->left);
            }

            if (node->right) {
                adj[node->val].push_back(node->right->val);
                adj[node->right->val].push_back(node->val);
                q.push(node->right);
            }
        }

        int time = 0;
        queue<int> infected;
        infected.push(start);
        unordered_set<int> visited;
        visited.insert(start);

        while (!infected.empty()) {
            int size = infected.size();
            for (int i = 0; i < size; ++i) {
                int node = infected.front();
                infected.pop();

                for (int neighbor : adj[node]) {
                    if (visited.find(neighbor) == visited.end()) {
                        infected.push(neighbor);
                        visited.insert(neighbor);
                    }
                }
            }
            if (!infected.empty()) {
                time++;
            }
        }

        return time;
    }
};