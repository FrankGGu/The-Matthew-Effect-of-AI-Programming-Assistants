class Solution {
public:
    int countSubtrees(int n, vector<vector<int>>& edges) {
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }
        vector<int> maxDistance(n, 0);
        int result = 0;

        function<int(int, int)> dfs = [&](int node, int parent) {
            int max1 = 0, max2 = 0;
            for (int neighbor : graph[node]) {
                if (neighbor == parent) continue;
                int dist = dfs(neighbor, node) + 1;
                if (dist > max1) {
                    max2 = max1;
                    max1 = dist;
                } else if (dist > max2) {
                    max2 = dist;
                }
            }
            maxDistance[node] = max1 + max2;
            if (maxDistance[node] >= 2) result++;
            return max1;
        };

        dfs(0, -1);
        return result;
    }
};