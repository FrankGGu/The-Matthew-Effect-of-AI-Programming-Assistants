class Solution {
public:
    int maximizeScore(vector<int>& nums, vector<vector<int>>& edges) {
        int n = nums.size();
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        int maxScore = 0;
        vector<bool> visited(n, false);

        function<void(int, int)> dfs = [&](int node, int currentScore) {
            visited[node] = true;
            maxScore = max(maxScore, currentScore);
            for (int neighbor : graph[node]) {
                if (!visited[neighbor]) {
                    dfs(neighbor, currentScore + nums[neighbor]);
                }
            }
            visited[node] = false;
        };

        for (int i = 0; i < n; ++i) {
            dfs(i, nums[i]);
        }

        return maxScore;
    }
};