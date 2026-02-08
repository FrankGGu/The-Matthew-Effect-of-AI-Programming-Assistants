#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    vector<bool> checkIfPrerequisite(int numCourses, vector<vector<int>>& prerequisites, vector<vector<int>>& queries) {
        vector<vector<int>> graph(numCourses);
        vector<int> inDegree(numCourses, 0);
        for (const auto& p : prerequisites) {
            graph[p[1]].push_back(p[0]);
            inDegree[p[0]]++;
        }

        vector<vector<bool>> reachable(numCourses, vector<bool>(numCourses, false));
        queue<int> q;

        for (int i = 0; i < numCourses; ++i) {
            if (inDegree[i] == 0) {
                q.push(i);
            }
        }

        while (!q.empty()) {
            int u = q.front();
            q.pop();
            for (int v : graph[u]) {
                reachable[u][v] = true;
                for (int i = 0; i < numCourses; ++i) {
                    if (reachable[i][u]) {
                        reachable[i][v] = true;
                    }
                }
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        vector<bool> result(queries.size());
        for (int i = 0; i < queries.size(); ++i) {
            result[i] = reachable[queries[i][0]][queries[i][1]];
        }

        return result;
    }
};