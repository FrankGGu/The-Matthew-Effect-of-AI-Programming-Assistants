#include <vector>
#include <string>
#include <utility>
#include <functional>
#include <unordered_map>

class Solution {
public:
    long long countPalindromePaths(std::vector<int>& parent, std::string s) {
        int n = parent.size();
        std::vector<std::vector<std::pair<int, int>>> adj(n);
        for (int i = 1; i < n; ++i) {
            adj[parent[i]].push_back({i, 1 << (s[i] - 'a')});
        }

        std::vector<int> masks(n);
        std::function<void(int, int)> dfs = 
            [&](int u, int current_mask) {
            masks[u] = current_mask;
            for (auto& edge : adj[u]) {
                int v = edge.first;
                int char_mask = edge.second;
                dfs(v, current_mask ^ char_mask);
            }
        };

        dfs(0, 0);

        long long ans = 0;
        std::unordered_map<int, int> freq;

        for (int mask : masks) {
            ans += freq[mask];
            for (int i = 0; i < 26; ++i) {
                if (freq.count(mask ^ (1 << i))) {
                    ans += freq[mask ^ (1 << i)];
                }
            }
            freq[mask]++;
        }

        return ans;
    }
};