#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxEdgeSum(vector<int>& nums, vector<vector<int>>& edges) {
        int n = nums.size();
        vector<pair<int, int>> adj[n];
        for (auto& edge : edges) {
            adj[edge[0]].push_back({edge[1], min(nums[edge[0]], nums[edge[1]])});
            adj[edge[1]].push_back({edge[0], min(nums[edge[0]], nums[edge[1]])});
        }

        long long ans = 0;
        vector<int> edgeValues;
        for (int i = 0; i < n; ++i) {
            for (auto& neighbor : adj[i]) {
                edgeValues.push_back(neighbor.second);
            }
        }

        sort(edgeValues.rbegin(), edgeValues.rend());

        int k = min((int)edgeValues.size() / 2, n - 1);
        for (int i = 0; i < k; ++i) {
            ans += edgeValues[i];
        }

        return ans;
    }
};