#include <vector>
#include <queue>

class Solution {
public:
    std::vector<int> findOrder(int numCourses, std::vector<std::vector<int>>& prerequisites) {
        std::vector<std::vector<int>> adj(numCourses);
        std::vector<int> in_degree(numCourses, 0);

        for (const auto& p : prerequisites) {
            adj[p[1]].push_back(p[0]);
            in_degree[p[0]]++;
        }

        std::queue<int> q;
        for (int i = 0; i < numCourses; ++i) {
            if (in_degree[i] == 0) {
                q.push(i);
            }
        }

        std::vector<int> result;
        while (!q.empty()) {
            int u = q.front();
            q.pop();
            result.push_back(u);

            for (int v : adj[u]) {
                in_degree[v]--;
                if (in_degree[v] == 0) {
                    q.push(v);
                }
            }
        }

        if (result.size() == numCourses) {
            return result;
        }

        return {};
    }
};