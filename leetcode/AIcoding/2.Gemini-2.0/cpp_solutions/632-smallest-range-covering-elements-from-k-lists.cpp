#include <vector>
#include <queue>
#include <climits>

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

        int range_start = 0, range_end = INT_MAX;

        while (true) {
            auto curr = pq.top();
            pq.pop();

            int min_val = curr.first;
            int row = curr.second.first;
            int col = curr.second.second;

            if (max_val - min_val < range_end - range_start) {
                range_start = min_val;
                range_end = max_val;
            }

            if (col + 1 == nums[row].size()) {
                break;
            }

            pq.push({nums[row][col + 1], {row, col + 1}});
            max_val = max(max_val, nums[row][col + 1]);
        }

        return {range_start, range_end};
    }
};