class Solution {
public:
    vector<int> sumOfDistancesInTree(int n, vector<vector<int>>& edges) {
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            int u = edge[0], v = edge[1];
            graph[u].push_back(v);
            graph[v].push_back(u);
        }

        vector<int> count(n, 1);
        vector<int> res(n, 0);

        function<void(int, int)> postOrder = [&](int node, int parent) {
            for (int neighbor : graph[node]) {
                if (neighbor != parent) {
                    postOrder(neighbor, node);
                    count[node] += count[neighbor];
                    res[node] += res[neighbor] + count[neighbor];
                }
            }
        };

        function<void(int, int)> preOrder = [&](int node, int parent) {
            for (int neighbor : graph[node]) {
                if (neighbor != parent) {
                    res[neighbor] = res[node] - count[neighbor] + (n - count[neighbor]);
                    preOrder(neighbor, node);
                }
            }
        };

        postOrder(0, -1);
        preOrder(0, -1);

        return res;
    }
};