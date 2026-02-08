#include <vector>
#include <queue>
#include <limits>

using namespace std;

class Solution {
public:
    vector<int> smallestRange(vector<vector<int>>& nums) {
        int n = nums.size();
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> minHeap;
        int currentMax = numeric_limits<int>::min();
        vector<int> range = {0, numeric_limits<int>::max()};

        for (int i = 0; i < n; ++i) {
            minHeap.push({nums[i][0], i});
            currentMax = max(currentMax, nums[i][0]);
        }

        while (minHeap.size() == n) {
            auto [currentMin, row] = minHeap.top();
            minHeap.pop();

            if (currentMax - currentMin < range[1] - range[0]) {
                range = {currentMin, currentMax};
            }

            if (++index[row] < nums[row].size()) {
                minHeap.push({nums[row][index[row]], row});
                currentMax = max(currentMax, nums[row][index[row]]);
            }
        }

        return range;
    }

private:
    vector<int> index;
};