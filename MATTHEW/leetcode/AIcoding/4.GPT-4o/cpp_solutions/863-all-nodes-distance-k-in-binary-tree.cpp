#include <vector>
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
    vector<int> distanceK(TreeNode* root, TreeNode* target, int K) {
        unordered_map<TreeNode*, vector<TreeNode*>> graph;
        buildGraph(root, graph);
        return bfs(graph, target, K);
    }

private:
    void buildGraph(TreeNode* root, unordered_map<TreeNode*, vector<TreeNode*>>& graph) {
        if (!root) return;
        if (root->left) {
            graph[root].push_back(root->left);
            graph[root->left].push_back(root);
            buildGraph(root->left, graph);
        }
        if (root->right) {
            graph[root].push_back(root->right);
            graph[root->right].push_back(root);
            buildGraph(root->right, graph);
        }
    }

    vector<int> bfs(unordered_map<TreeNode*, vector<TreeNode*>>& graph, TreeNode* target, int K) {
        queue<TreeNode*> q;
        unordered_map<TreeNode*, bool> visited;
        q.push(target);
        visited[target] = true;
        int currentLevel = 0;

        while (!q.empty()) {
            if (currentLevel == K) break;
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                TreeNode* node = q.front();
                q.pop();
                for (auto& neighbor : graph[node]) {
                    if (!visited[neighbor]) {
                        visited[neighbor] = true;
                        q.push(neighbor);
                    }
                }
            }
            currentLevel++;
        }

        vector<int> result;
        while (!q.empty()) {
            result.push_back(q.front()->val);
            q.pop();
        }
        return result;
    }
};