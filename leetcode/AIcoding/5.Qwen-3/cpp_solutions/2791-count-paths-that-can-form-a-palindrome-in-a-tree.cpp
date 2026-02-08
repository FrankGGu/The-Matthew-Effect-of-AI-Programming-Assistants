#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countPalindromePaths(vector<vector<int>>& tree) {
        int n = tree.size();
        vector<vector<int>> adj(n);
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < tree[i].size(); ++j) {
                adj[i].push_back(tree[i][j]);
            }
        }

        unordered_map<int, int> freq;
        int result = 0;

        function<void(int, int)> dfs = [&](int node, int path) {
            freq[path]++;
            for (int neighbor : adj[node]) {
                dfs(neighbor, path ^ (1 << neighbor));
            }
        };

        dfs(0, 0);

        for (auto& [mask, count] : freq) {
            result += count * (count - 1) / 2;
            for (int i = 0; i < 32; ++i) {
                if ((mask ^ (1 << i)) == mask) continue;
                result += freq[mask] * freq[mask ^ (1 << i)];
            }
        }

        return result;
    }
};