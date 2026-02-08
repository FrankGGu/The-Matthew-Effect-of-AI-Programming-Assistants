#include <vector>

using namespace std;

class Solution {
public:
    vector<bool> checkIfPrerequisite(int numCourses, vector<vector<int>>& prerequisites, vector<vector<int>>& queries) {
        vector<vector<bool>> reachable(numCourses, vector<bool>(numCourses, false));
        vector<vector<int>> adj(numCourses);
        vector<int> inDegree(numCourses, 0);

        for (auto& pre : prerequisites) {
            adj[pre[0]].push_back(pre[1]);
            inDegree[pre[1]]++;
        }

        vector<int> q;
        for (int i = 0; i < numCourses; ++i) {
            if (inDegree[i] == 0) {
                q.push_back(i);
            }
        }

        while (!q.empty()) {
            int u = q.front();
            q.erase(q.begin());

            for (int v : adj[u]) {
                reachable[u][v] = true;
                for (int i = 0; i < numCourses; ++i) {
                    if (reachable[i][u]) {
                        reachable[i][v] = true;
                    }
                }
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.push_back(v);
                }
            }
        }

        vector<bool> result;
        for (auto& query : queries) {
            result.push_back(reachable[query[0]][query[1]]);
        }

        return result;
    }
};