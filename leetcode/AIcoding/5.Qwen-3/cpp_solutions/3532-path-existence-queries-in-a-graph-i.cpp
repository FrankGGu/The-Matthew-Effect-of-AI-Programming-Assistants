#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<bool> checkIfPrerequisite(int numCourses, vector<vector<int>>& prerequisites, vector<vector<int>>& queries) {
        vector<vector<int>> graph(numCourses);
        vector<int> inDegree(numCourses, 0);

        for (const auto& pre : prerequisites) {
            graph[pre[0]].push_back(pre[1]);
            inDegree[pre[1]]++;
        }

        vector<vector<int>> reachable(numCourses, vector<int>(numCourses, 0));

        queue<int> q;
        for (int i = 0; i < numCourses; ++i) {
            if (inDegree[i] == 0) {
                q.push(i);
            }
        }

        while (!q.empty()) {
            int node = q.front();
            q.pop();

            for (int neighbor : graph[node]) {
                reachable[node][neighbor] = 1;
                for (int i = 0; i < numCourses; ++i) {
                    if (reachable[i][node] == 1) {
                        reachable[i][neighbor] = 1;
                    }
                }
                inDegree[neighbor]--;
                if (inDegree[neighbor] == 0) {
                    q.push(neighbor);
                }
            }
        }

        vector<bool> result;
        for (const auto& query : queries) {
            result.push_back(reachable[query[0]][query[1]] == 1);
        }

        return result;
    }
};