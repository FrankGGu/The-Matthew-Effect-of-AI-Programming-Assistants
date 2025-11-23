#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minCostArrayPermutation(vector<int>& nums) {
        int n = nums.size();
        vector<int> cost(n, 0);
        vector<bool> visited(n, false);
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;

        for (int i = 0; i < n; ++i) {
            pq.push({nums[i], i});
        }

        int result = 0;
        while (!pq.empty()) {
            auto [val, idx] = pq.top();
            pq.pop();

            if (visited[idx]) continue;
            visited[idx] = true;
            result += val;

            int next_idx = (idx + 1) % n;
            if (!visited[next_idx]) {
                cost[next_idx] = min(cost[next_idx], val + nums[next_idx]);
                pq.push({cost[next_idx], next_idx});
            }

            int prev_idx = (idx - 1 + n) % n;
            if (!visited[prev_idx]) {
                cost[prev_idx] = min(cost[prev_idx], val + nums[prev_idx]);
                pq.push({cost[prev_idx], prev_idx});
            }
        }

        return result;
    }
};