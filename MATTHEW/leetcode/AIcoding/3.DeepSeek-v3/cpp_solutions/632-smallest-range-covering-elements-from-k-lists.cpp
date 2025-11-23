#include <vector>
#include <queue>
#include <climits>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> smallestRange(vector<vector<int>>& nums) {
        int k = nums.size();
        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<pair<int, pair<int, int>>>> pq;
        int max_val = INT_MIN;
        for (int i = 0; i < k; ++i) {
            pq.push({nums[i][0], {i, 0}});
            max_val = max(max_val, nums[i][0]);
        }
        int start = -1, end = -1, range = INT_MAX;
        while (true) {
            auto top = pq.top();
            pq.pop();
            int val = top.first;
            int i = top.second.first;
            int j = top.second.second;
            if (max_val - val < range) {
                range = max_val - val;
                start = val;
                end = max_val;
            }
            if (j + 1 == nums[i].size()) break;
            pq.push({nums[i][j + 1], {i, j + 1}});
            max_val = max(max_val, nums[i][j + 1]);
        }
        return {start, end};
    }
};