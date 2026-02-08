class Solution {
public:
    int numOfMinutes(int n, int headID, vector<int>& manager, vector<int>& informTime) {
        vector<vector<int>> graph(n);
        for (int i = 0; i < n; ++i) {
            if (manager[i] != -1) {
                graph[manager[i]].push_back(i);
            }
        }

        return dfs(headID, graph, informTime);
    }

private:
    int dfs(int node, const vector<vector<int>>& graph, const vector<int>& informTime) {
        int maxTime = 0;
        for (int subordinate : graph[node]) {
            maxTime = max(maxTime, dfs(subordinate, graph, informTime));
        }
        return maxTime + informTime[node];
    }
};