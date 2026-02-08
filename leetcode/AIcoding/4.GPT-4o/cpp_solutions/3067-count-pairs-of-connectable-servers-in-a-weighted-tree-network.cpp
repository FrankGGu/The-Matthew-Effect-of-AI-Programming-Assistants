class Solution {
public:
    int countPairs(vector<int>& nums, int d) {
        int n = nums.size();
        vector<vector<int>> graph(n);
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (abs(nums[i] - nums[j]) <= d) {
                    graph[i].push_back(j);
                    graph[j].push_back(i);
                }
            }
        }

        vector<bool> visited(n, false);
        int result = 0;

        function<int(int)> dfs = [&](int node) {
            visited[node] = true;
            int count = 1;
            for (int neighbor : graph[node]) {
                if (!visited[neighbor]) {
                    count += dfs(neighbor);
                }
            }
            return count;
        };

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                int size = dfs(i);
                result += size * (size - 1) / 2;
            }
        }

        return result;
    }
};