#include <vector>

using namespace std;

class Solution {
public:
    int countValidPaths(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n + 1);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<bool> isPrime(n + 1, true);
        isPrime[0] = isPrime[1] = false;
        for (int i = 2; i * i <= n; ++i) {
            if (isPrime[i]) {
                for (int j = i * i; j <= n; j += i) {
                    isPrime[j] = false;
                }
            }
        }

        int ans = 0;
        for (int i = 1; i <= n; ++i) {
            if (isPrime[i]) continue;
            vector<int> component;
            vector<bool> visited(n + 1, false);
            function<void(int)> dfs = [&](int u) {
                visited[u] = true;
                component.push_back(u);
                for (int v : adj[u]) {
                    if (!visited[v] && !isPrime[v]) {
                        dfs(v);
                    }
                }
            };

            if (!visited[i]) {
                dfs(i);

                for(int node : component){
                    visited[node] = false;
                }

                function<int(int)> countPaths = [&](int start) {
                    visited[start] = true;
                    int count = 1;
                    for (int neighbor : adj[start]) {
                        if (!isPrime[neighbor] && find(component.begin(), component.end(), neighbor) != component.end() ) continue;
                        if (!visited[neighbor]) {
                            count += countPaths(neighbor);
                        }
                    }
                    return count;
                };

                long long totalPaths = 0;
                for(int node : component){
                    totalPaths += countPaths(node);
                    for(int comNode : component){
                        visited[comNode] = false;
                    }
                }

                ans += totalPaths / 2;
                component.clear();
            }
        }

        for(int i = 1; i <= n; i++){
            if(isPrime[i]){
                ans++;
            }
        }

        return ans;
    }
};