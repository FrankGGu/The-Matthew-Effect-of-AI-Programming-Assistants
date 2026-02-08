#include <vector>
#include <string>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int largestColorValue(string colors, vector<vector<int>>& edges) {
        int n = colors.size();
        vector<vector<int>> graph(n);
        vector<int> indegree(n, 0);
        vector<vector<int>> colorCount(n, vector<int>(26, 0));

        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            indegree[edge[1]]++;
        }

        queue<int> q;
        for (int i = 0; i < n; ++i) {
            if (indegree[i] == 0) {
                q.push(i);
                colorCount[i][colors[i] - 'a']++;
            }
        }

        int maxColorValue = 0;

        while (!q.empty()) {
            int node = q.front();
            q.pop();
            maxColorValue = max(maxColorValue, *max_element(colorCount[node].begin(), colorCount[node].end()));

            for (int neighbor : graph[node]) {
                for (int i = 0; i < 26; ++i) {
                    colorCount[neighbor][i] = max(colorCount[neighbor][i], colorCount[node][i] + (i == colors[neighbor] - 'a'));
                }
                if (--indegree[neighbor] == 0) {
                    q.push(neighbor);
                }
            }
        }

        return maxColorValue;
    }
};