#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minImpossibleOR(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0] - 1].push_back(edge[1] - 1);
            adj[edge[1] - 1].push_back(edge[0] - 1);
        }

        vector<bool> visited(n, false);
        vector<int> component;

        function<void(int)> dfs = [&](int u) {
            visited[u] = true;
            component.push_back(u);
            for (int v : adj[u]) {
                if (!visited[v]) {
                    dfs(v);
                }
            }
        };

        vector<vector<int>> components;
        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                component.clear();
                dfs(i);
                components.push_back(component);
            }
        }

        int ans = 1;
        for(int i = 0; i < components.size(); ++i){

            int edge_count = 0;
            for(int u: components[i]){
                edge_count += adj[u].size();
            }
            edge_count /= 2;

            if(edge_count >= components[i].size()){
                continue;
            }else{
                return 1;
            }
        }

        int k = 1;
        while(true){
            bool possible = false;
            for(int i = 0; i < components.size(); ++i){

                int edge_count = 0;
                for(int u: components[i]){
                    edge_count += adj[u].size();
                }
                edge_count /= 2;

                if(edge_count < components[i].size()){
                    return 1;
                }

            }

            for(int i = 0; i < components.size(); ++i){
                bool connected = false;
                for(int j = 0; j < components[i].size(); ++j){
                    for(int l = j + 1; l < components[i].size(); ++l){
                        bool found = false;
                        for(int neighbor : adj[components[i][j]]){
                            if(neighbor == components[i][l]){
                                found = true;
                                break;
                            }
                        }
                        if(found){
                            connected = true;
                            break;
                        }
                    }
                    if(connected){
                        break;
                    }
                }
                if(!connected){
                    return 1;
                }
            }

            k++;
            ans = 1;
            while((1 << (ans - 1)) <= n){
                if((1 << (ans - 1)) & (1 << (k-1))){
                    break;
                }
                ans++;
            }

            return (1<<k);
        }

        return -1;
    }
};