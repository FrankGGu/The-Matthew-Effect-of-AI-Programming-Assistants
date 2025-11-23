#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> findOrder(int numCourses, vector<vector<int>>& prerequisites) {
        vector<int> inDegree(numCourses, 0);
        vector<vector<int>> adj(numCourses);

        for (auto& pre : prerequisites) {
            int course = pre[0];
            int prerequisite = pre[1];
            inDegree[course]++;
            adj[prerequisite].push_back(course);
        }

        queue<int> q;
        for (int i = 0; i < numCourses; ++i) {
            if (inDegree[i] == 0) {
                q.push(i);
            }
        }

        vector<int> result;
        int count = 0;

        while (!q.empty()) {
            int u = q.front();
            q.pop();
            result.push_back(u);
            count++;

            for (int v : adj[u]) {
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        if (count == numCourses) {
            return result;
        } else {
            return {};
        }
    }
};