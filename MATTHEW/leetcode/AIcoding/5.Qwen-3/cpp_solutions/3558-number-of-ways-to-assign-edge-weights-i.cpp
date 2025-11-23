#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numberOfWays(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n);
        for (auto& e : edges) {
            adj[e[0]].push_back(e[1]);
            adj[e[1]].push_back(e[0]);
        }

        vector<int> color(n, 0);
        unordered_map<int, int> freq;
        int result = 0;

        function<void(int, int)> dfs = [&](int node, int parent) {
            color[node] = 1;
            freq[1]++;
            for (int neighbor : adj[node]) {
                if (neighbor != parent) {
                    dfs(neighbor, node);
                }
            }
        };

        dfs(0, -1);

        for (auto [c, cnt] : freq) {
            result += cnt * (cnt - 1) / 2;
        }

        return result;
    }
};