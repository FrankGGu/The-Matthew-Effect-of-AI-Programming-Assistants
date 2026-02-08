class Solution {
public:
    int maxScore(vector<int>& nums, vector<vector<int>>& edges) {
        int n = nums.size();
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<int> score(n);
        for (int i = 0; i < n; ++i) {
            score[i] = nums[i];
        }

        int maxScore = 0;
        vector<bool> visited(n, false);

        function<int(int)> dfs = [&](int node) {
            visited[node] = true;
            vector<int> childScores;
            for (int neighbor : graph[node]) {
                if (!visited[neighbor]) {
                    childScores.push_back(dfs(neighbor));
                }
            }
            int localMax = score[node];
            for (int childScore : childScores) {
                localMax = max(localMax, childScore);
            }
            return localMax;
        };

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                maxScore += dfs(i);
            }
        }

        return maxScore;
    }
};