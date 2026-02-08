#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int longestCycle(vector<int>& edges) {
        int n = edges.size();
        vector<int> indegree(n, 0);
        for (int edge : edges) {
            if (edge != -1) {
                indegree[edge]++;
            }
        }

        vector<bool> visited(n, false);
        vector<int> q;
        for (int i = 0; i < n; ++i) {
            if (indegree[i] == 0) {
                q.push_back(i);
                visited[i] = true;
            }
        }

        int head = 0;
        while (head < q.size()) {
            int u = q[head++];
            int v = edges[u];
            if (v != -1) {
                indegree[v]--;
                if (indegree[v] == 0) {
                    q.push_back(v);
                    visited[v] = true;
                }
            }
        }

        int maxCycle = -1;
        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                vector<int> dist(n, -1);
                dist[i] = 1;
                int curr = i;
                int next = edges[curr];

                while (next != -1 && dist[next] == -1) {
                    dist[next] = dist[curr] + 1;
                    curr = next;
                    next = edges[curr];
                }

                if (next != -1 && dist[next] != -1) {
                    maxCycle = max(maxCycle, dist[curr] - dist[next] + 1);
                }
            }
        }

        return maxCycle;
    }
};