#include <vector>

using namespace std;

class Solution {
public:
    vector<int> countPairs(int n, vector<vector<int>>& edges, vector<int>& queries) {
        vector<int> degree(n + 1, 0);
        vector<vector<int>> cnt(n + 1, vector<int>(n + 1, 0));
        for (auto& edge : edges) {
            int u = edge[0], v = edge[1];
            degree[u]++;
            degree[v]++;
            if (u > v) swap(u, v);
            cnt[u][v]++;
        }

        vector<int> ans;
        for (int query : queries) {
            int count = 0;
            for (int i = 1; i <= n; i++) {
                for (int j = i + 1; j <= n; j++) {
                    if (degree[i] + degree[j] - cnt[i][j] > query) {
                        count++;
                    }
                }
            }
            ans.push_back(count);
        }

        return ans;
    }
};