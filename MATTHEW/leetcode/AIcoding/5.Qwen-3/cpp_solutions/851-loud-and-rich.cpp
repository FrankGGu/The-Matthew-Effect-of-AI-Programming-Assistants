#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> loudAndRich(vector<int>& richer, vector<int>& quiet) {
        int n = quiet.size();
        vector<vector<int>> graph(n);
        vector<int> inDegree(n, 0);

        for (int i = 0; i < richer.size(); ++i) {
            int u = richer[i];
            int v = i;
            graph[u].push_back(v);
            inDegree[v]++;
        }

        vector<int> result(n);
        queue<int> q;

        for (int i = 0; i < n; ++i) {
            result[i] = i;
        }

        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                q.push(i);
            }
        }

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            for (int v : graph[u]) {
                if (quiet[result[v]] > quiet[result[u]]) {
                    result[v] = result[u];
                }
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        return result;
    }
};