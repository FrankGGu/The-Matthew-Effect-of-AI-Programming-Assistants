#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int collectTheCoins(vector<int>& coins, vector<vector<int>>& edges) {
        int n = coins.size();
        vector<vector<int>> adj(n);
        vector<int> degree(n, 0);

        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
            degree[edge[0]]++;
            degree[edge[1]]++;
        }

        int remainingNodes = n;
        queue<int> q;

        for (int i = 0; i < n; i++) {
            if (degree[i] == 1 && coins[i] == 0) {
                q.push(i);
            }
        }

        while (!q.empty()) {
            int u = q.front();
            q.pop();
            remainingNodes--;
            degree[u] = 0;

            for (int v : adj[u]) {
                if (degree[v] > 1) {
                    degree[v]--;
                    if (degree[v] == 1 && coins[v] == 0) {
                        q.push(v);
                    }
                }
            }
        }

        for (int i = 0; i < n; i++) {
            if (degree[i] == 1 && coins[i] == 1) {
                q.push(i);
            }
        }

        int count = 0;
        while (!q.empty() && count < 2) {
            int size = q.size();
            for(int i = 0; i < size; ++i){
                int u = q.front();
                q.pop();
                remainingNodes--;
                degree[u] = 0;

                for (int v : adj[u]) {
                    if (degree[v] > 1) {
                        degree[v]--;
                        if (degree[v] == 1) {
                            q.push(v);
                        }
                    }
                }
            }
            count++;
        }

        if (remainingNodes <= 1) return 0;

        return 2 * (remainingNodes - 1);
    }
};