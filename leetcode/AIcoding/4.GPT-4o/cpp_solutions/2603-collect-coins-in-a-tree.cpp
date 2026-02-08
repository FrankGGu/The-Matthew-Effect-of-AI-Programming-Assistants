class Solution {
public:
    int collectTheCoins(vector<int>& coins, vector<vector<int>>& edges) {
        int n = coins.size();
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<int> leafs;
        vector<bool> visited(n, false);
        function<void(int, int)> dfs = [&](int node, int parent) {
            visited[node] = true;
            bool isLeaf = true;
            for (int neighbor : graph[node]) {
                if (neighbor != parent && !visited[neighbor]) {
                    isLeaf = false;
                    dfs(neighbor, node);
                }
            }
            if (isLeaf && coins[node]) leafs.push_back(node);
        };

        dfs(0, -1);

        if (leafs.empty()) return 0;

        int dist = 0;
        vector<int> new_leafs;
        unordered_set<int> visitedLeafs(leafs.begin(), leafs.end());

        for (int leaf : leafs) {
            int node = leaf;
            while (node != 0 && visitedLeafs.find(node) != visitedLeafs.end()) {
                visitedLeafs.erase(node);
                dist++;
                node = graph[node][0]; // move towards root
            }
        }

        return dist + (leafs.size() - 1) * 2;
    }
};