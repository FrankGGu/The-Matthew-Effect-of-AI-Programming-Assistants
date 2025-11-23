#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countPaths(int n, vector<vector<int>>& edges) {
        vector<vector<pair<int, int>>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back({edge[1], edge[2]});
            adj[edge[1]].push_back({edge[0], edge[2]});
        }

        int ans = 0;
        unordered_map<int, int> count;
        count[0] = 1;

        function<void(int, int, int, int)> dfs = 
            [&](int u, int parent, int mask, int depth) {
            ans += count[mask];
            for (int i = 0; i < 26; ++i) {
                ans += count[mask ^ (1 << i)];
            }

            for (auto& neighbor : adj[u]) {
                int v = neighbor.first;
                int w = neighbor.second;
                if (v != parent) {
                    count[mask]++;
                    dfs(v, u, mask ^ (1 << w), depth + 1);
                    count[mask]--;
                }
            }
        };

        for(int i = 0; i < n; ++i){
            unordered_map<int, int> temp_count;
            temp_count[0] = 1;
            function<void(int, int, int)> dfs2 = 
            [&](int u, int parent, int mask) {

                ans += temp_count[mask];
                for (int i = 0; i < 26; ++i) {
                    ans += temp_count[mask ^ (1 << i)];
                }

                for (auto& neighbor : adj[u]) {
                    int v = neighbor.first;
                    int w = neighbor.second;
                    if (v != parent) {
                        temp_count[mask]++;
                        dfs2(v, u, mask ^ (1 << w));
                        temp_count[mask]--;
                    }
                }
            };
            dfs(i, -1, 0, 0);
        }

        int path_count = 0;
        for(int i = 0; i < edges.size(); ++i) path_count +=1;
        return ans/2;
    }
};