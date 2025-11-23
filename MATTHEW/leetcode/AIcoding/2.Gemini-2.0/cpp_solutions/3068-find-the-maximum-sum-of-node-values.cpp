#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxSum(vector<int>& nums, vector<vector<int>>& edges) {
        int n = nums.size();
        vector<vector<int>> adj(n);
        vector<int> degree(n, 0);

        for (auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj[u].push_back(v);
            adj[v].push_back(u);
            degree[u]++;
            degree[v]++;
        }

        vector<bool> removed(n, false);
        vector<int> q;
        for (int i = 0; i < n; ++i) {
            if (degree[i] == 1) {
                q.push_back(i);
                removed[i] = true;
            }
        }

        while (!q.empty()) {
            int u = q.front();
            q.erase(q.begin());

            for (int v : adj[u]) {
                if (!removed[v]) {
                    degree[v]--;
                    if (degree[v] == 1) {
                        q.push_back(v);
                        removed[v] = true;
                    }
                }
            }
        }

        long long sum = 0;
        for (int i = 0; i < n; ++i) {
            if (!removed[i]) {
                sum += nums[i];
            }
        }

        return (int)sum;
    }
};