class Solution {
public:
    int amountOfTime(TreeNode* root, int start) {
        unordered_map<int, vector<int>> graph;
        buildGraph(root, graph);

        queue<int> q;
        unordered_set<int> visited;
        q.push(start);
        visited.insert(start);
        int time = -1;

        while (!q.empty()) {
            int size = q.size();
            time++;
            for (int i = 0; i < size; ++i) {
                int current = q.front();
                q.pop();
                for (int neighbor : graph[current]) {
                    if (visited.find(neighbor) == visited.end()) {
                        visited.insert(neighbor);
                        q.push(neighbor);
                    }
                }
            }
        }
        return time;
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