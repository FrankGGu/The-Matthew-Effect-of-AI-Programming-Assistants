class Solution {
public:
    int minimumScore(vector<int>& nums, vector<vector<int>>& edges) {
        int n = nums.size();
        vector<int> minScore(n, INT_MAX);
        vector<vector<int>> graph(n);

        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        function<void(int, int)> dfs = [&](int node, int score) {
            if (score < minScore[node]) {
                minScore[node] = score;
                for (int neighbor : graph[node]) {
                    dfs(neighbor, min(score, nums[neighbor]));
                }
            }
        };

        int result = INT_MAX;
        for (int i = 0; i < n; ++i) {
            fill(minScore.begin(), minScore.end(), INT_MAX);
            dfs(i, nums[i]);
            for (int j = 0; j < n; ++j) {
                if (i != j) {
                    result = min(result, minScore[i] + minScore[j]);
                }
            }
        }

        return result;
    }
};