class Solution {
public:
    int findCircleNum(vector<vector<int>>& isConnected) {
        int n = isConnected.size();
        vector<bool> visited(n, false);
        int count = 0;

        function<void(int)> dfs = [&](int i) {
            for (int j = 0; j < n; ++j) {
                if (isConnected[i][j] == 1 && !visited[j]) {
                    visited[j] = true;
                    dfs(j);
                }
            }
        };

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                dfs(i);
                count++;
            }
        }

        return count;
    }
};