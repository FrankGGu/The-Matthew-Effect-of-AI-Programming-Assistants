#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int parallelCourses(int n, vector<vector<int>>& relations) {
        vector<vector<int>> graph(n + 1);
        vector<int> inDegree(n + 1, 0);

        for (auto& relation : relations) {
            int u = relation[0];
            int v = relation[1];
            graph[u].push_back(v);
            inDegree[v]++;
        }

        queue<int> q;
        for (int i = 1; i <= n; ++i) {
            if (inDegree[i] == 0) {
                q.push(i);
            }
        }

        int time = 0;
        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                int node = q.front();
                q.pop();
                for (int neighbor : graph[node]) {
                    inDegree[neighbor]--;
                    if (inDegree[neighbor] == 0) {
                        q.push(neighbor);
                    }
                }
            }
            time++;
        }

        for (int i = 1; i <= n; ++i) {
            if (inDegree[i] != 0) {
                return -1;
            }
        }

        return time;
    }
};