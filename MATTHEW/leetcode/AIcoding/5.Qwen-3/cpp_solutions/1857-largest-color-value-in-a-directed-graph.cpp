#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int largestColorValue(string colors, vector<vector<int>>& edges) {
        int n = colors.size();
        vector<vector<int>> adj(n);
        vector<int> inDegree(n, 0);

        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            inDegree[edge[1]]++;
        }

        queue<int> q;
        vector<vector<int>> colorCount(n, vector<int>(26, 0));

        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                q.push(i);
            }
        }

        while (!q.empty()) {
            int node = q.front();
            q.pop();

            for (int neighbor : adj[node]) {
                for (int i = 0; i < 26; ++i) {
                    colorCount[neighbor][i] = max(colorCount[neighbor][i], colorCount[node][i]);
                }
                colorCount[neighbor][colors[node] - 'a']++;

                inDegree[neighbor]--;
                if (inDegree[neighbor] == 0) {
                    q.push(neighbor);
                }
            }
        }

        int maxColorValue = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < 26; ++j) {
                maxColorValue = max(maxColorValue, colorCount[i][j]);
            }
        }

        return maxColorValue;
    }
};