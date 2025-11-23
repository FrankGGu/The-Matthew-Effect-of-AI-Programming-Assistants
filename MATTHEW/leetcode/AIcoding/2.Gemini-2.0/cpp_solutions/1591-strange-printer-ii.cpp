#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool isPrintable(vector<vector<int>>& targetGrid) {
        int m = targetGrid.size();
        int n = targetGrid[0].size();

        vector<vector<int>> ranges(61, vector<int>(4, -1));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int color = targetGrid[i][j];
                if (ranges[color][0] == -1) {
                    ranges[color][0] = i;
                    ranges[color][1] = i;
                    ranges[color][2] = j;
                    ranges[color][3] = j;
                } else {
                    ranges[color][0] = min(ranges[color][0], i);
                    ranges[color][1] = max(ranges[color][1], i);
                    ranges[color][2] = min(ranges[color][2], j);
                    ranges[color][3] = max(ranges[color][3], j);
                }
            }
        }

        vector<vector<int>> adj(61);
        vector<int> indegree(61, 0);

        for (int i = 1; i <= 60; ++i) {
            if (ranges[i][0] == -1) continue;
            for (int j = 1; j <= 60; ++j) {
                if (i == j || ranges[j][0] == -1) continue;
                if (ranges[i][0] <= ranges[j][1] && ranges[i][1] >= ranges[j][0] &&
                    ranges[i][2] <= ranges[j][3] && ranges[i][3] >= ranges[j][2]) {
                    bool conflict = false;
                    for (int row = ranges[j][0]; row <= ranges[j][1]; ++row) {
                        for (int col = ranges[j][2]; col <= ranges[j][3]; ++col) {
                            if (targetGrid[row][col] == j) continue;
                            if (targetGrid[row][col] == i) {
                                conflict = true;
                                break;
                            }
                        }
                        if (conflict) break;
                    }

                    if (conflict) {
                        adj[i].push_back(j);
                        indegree[j]++;
                    }
                }
            }
        }

        queue<int> q;
        for (int i = 1; i <= 60; ++i) {
            if (ranges[i][0] != -1 && indegree[i] == 0) {
                q.push(i);
            }
        }

        int count = 0;
        while (!q.empty()) {
            int u = q.front();
            q.pop();
            count++;
            for (int v : adj[u]) {
                indegree[v]--;
                if (indegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        int num_colors = 0;
        for (int i = 1; i <= 60; ++i) {
            if (ranges[i][0] != -1) {
                num_colors++;
            }
        }

        return count == num_colors;
    }
};