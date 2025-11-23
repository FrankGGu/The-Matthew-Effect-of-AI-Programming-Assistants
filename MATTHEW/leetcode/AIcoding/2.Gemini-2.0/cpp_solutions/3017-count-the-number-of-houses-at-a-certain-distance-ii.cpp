#include <vector>
#include <queue>
#include <map>

using namespace std;

class Solution {
public:
    vector<long long> countOfPairs(int n, int firstHouse, int secondHouse, vector<vector<int>>& edges) {
        firstHouse--;
        secondHouse--;

        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0] - 1].push_back(edge[1] - 1);
            adj[edge[1] - 1].push_back(edge[0] - 1);
        }

        vector<int> dist1(n, -1);
        vector<int> dist2(n, -1);

        queue<int> q1;
        q1.push(firstHouse);
        dist1[firstHouse] = 0;

        while (!q1.empty()) {
            int u = q1.front();
            q1.pop();

            for (int v : adj[u]) {
                if (dist1[v] == -1) {
                    dist1[v] = dist1[u] + 1;
                    q1.push(v);
                }
            }
        }

        queue<int> q2;
        q2.push(secondHouse);
        dist2[secondHouse] = 0;

        while (!q2.empty()) {
            int u = q2.front();
            q2.pop();

            for (int v : adj[u]) {
                if (dist2[v] == -1) {
                    dist2[v] = dist2[u] + 1;
                    q2.push(v);
                }
            }
        }

        vector<long long> ans(n);
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int minDist = min(dist1[i] + dist1[j], dist2[i] + dist2[j]);
                minDist = min(minDist, dist1[i] + dist2[j] + 1);
                minDist = min(minDist, dist2[i] + dist1[j] + 1);
                ans[minDist]++;
            }
        }

        return ans;
    }
};