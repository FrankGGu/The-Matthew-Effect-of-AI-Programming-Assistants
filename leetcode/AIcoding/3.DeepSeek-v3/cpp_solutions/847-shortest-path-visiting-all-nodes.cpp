class Solution {
public:
    int shortestPathLength(vector<vector<int>>& graph) {
        int n = graph.size();
        if (n == 1) return 0;

        int final_mask = (1 << n) - 1;
        queue<pair<int, int>> q;
        vector<vector<bool>> visited(n, vector<bool>(final_mask + 1, false));

        for (int i = 0; i < n; ++i) {
            q.push({i, 1 << i});
            visited[i][1 << i] = true;
        }

        int steps = 0;
        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                auto [node, mask] = q.front();
                q.pop();

                if (mask == final_mask) {
                    return steps;
                }

                for (int neighbor : graph[node]) {
                    int new_mask = mask | (1 << neighbor);
                    if (!visited[neighbor][new_mask]) {
                        visited[neighbor][new_mask] = true;
                        q.push({neighbor, new_mask});
                    }
                }
            }
            ++steps;
        }
        return -1;
    }
};