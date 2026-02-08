class Solution {
public:
    long long maximizeSum(vector<int>& nums, vector<vector<int>>& edges) {
        int n = nums.size();
        vector<vector<int>> graph(n);
        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<bool> visited(n, false);
        long long result = 0;

        function<long long(int)> dfs = [&](int node) {
            visited[node] = true;
            long long sum = nums[node];
            for (int neighbor : graph[node]) {
                if (!visited[neighbor]) {
                    sum += dfs(neighbor);
                }
            }
            return sum;
        };

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                result = max(result, dfs(i));
            }
        }

        return result;
    }
};