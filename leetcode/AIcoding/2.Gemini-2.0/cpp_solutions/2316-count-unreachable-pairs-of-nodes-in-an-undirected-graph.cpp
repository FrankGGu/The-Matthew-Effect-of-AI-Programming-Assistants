#include <vector>

using namespace std;

class Solution {
public:
    long long countPairs(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<bool> visited(n, false);
        vector<long long> componentSizes;

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                long long count = 0;
                vector<int> q;
                q.push_back(i);
                visited[i] = true;
                int head = 0;

                while (head < q.size()) {
                    int u = q[head++];
                    count++;

                    for (int v : adj[u]) {
                        if (!visited[v]) {
                            visited[v] = true;
                            q.push_back(v);
                        }
                    }
                }
                componentSizes.push_back(count);
            }
        }

        long long result = 0;
        long long remainingNodes = n;
        for (long long size : componentSizes) {
            result += size * (remainingNodes - size);
            remainingNodes -= size;
        }

        return result;
    }
};