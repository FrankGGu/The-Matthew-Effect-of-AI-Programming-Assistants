#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximumValueSum(vector<int>& nums, vector<vector<int>>& edges, int k) {
        int n = nums.size();
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        long long sum = 0;
        int min_val = INT_MAX;
        int count = 0;

        for (int i = 0; i < n; ++i) {
            if (nums[i] < k) {
                sum += nums[i];
            } else {
                sum += (2 * k - nums[i]);
                count++;
            }
            min_val = min(min_val, nums[i]);
        }

        if (count == 0) {
            return sum - min(k, min_val) + min(k, (2 * k - min_val));
        }

        return sum;
    }
};