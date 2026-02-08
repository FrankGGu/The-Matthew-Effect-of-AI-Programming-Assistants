#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minimumAmount(int n, vector<vector<int>>& edges, int bob) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<int> bob_path;
        vector<bool> visited(n, false);
        function<bool(int, int)> find_bob_path = [&](int u, int parent) {
            visited[u] = true;
            bob_path.push_back(u);
            if (u == bob) {
                return true;
            }
            for (int v : adj[u]) {
                if (v != parent && !visited[v]) {
                    if (find_bob_path(v, u)) {
                        return true;
                    }
                }
            }
            bob_path.pop_back();
            return false;
        };

        find_bob_path(0, -1);

        vector<int> bob_time(n, -1);
        for (int i = 0; i < bob_path.size(); ++i) {
            bob_time[bob_path[i]] = i;
        }

        long long ans = 0;
        vector<bool> vis(n, false);
        function<void(int, int, int)> dfs = [&](int u, int parent, int time) {
            vis[u] = true;

            long long damage = 0;
            if(bob_time[u] == -1 || bob_time[u] > time){
                damage = 1;
            } else if(bob_time[u] == time){
                damage = 0;
            } else {
                damage = 1;
            }

            bool is_leaf = true;
            for (int v : adj[u]) {
                if (v != parent) {
                    is_leaf = false;
                    dfs(v, u, time + 1);
                }
            }

            if (is_leaf) {
                ans += damage;
            } else {
                int count = 0;
                for(int v: adj[u]){
                    if(v != parent){
                        count++;
                    }
                }
                if(count > 0){
                    ans += damage;
                }
            }
        };

        dfs(0, -1, 0);
        return ans;
    }
};