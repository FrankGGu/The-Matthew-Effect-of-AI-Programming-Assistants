#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> getFinalState(vector<int>& nums, int k, int multiplier) {
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> minHeap;

        for (int i = 0; i < nums.size(); ++i) {
            minHeap.push({nums[i], i});
        }

        for (int i = 0; i < k; ++i) {
            auto [val, idx] = minHeap.top();
            minHeap.pop();
            val *= multiplier;
            minHeap.push({val, idx});
        }

        vector<int> result(nums.size());
        while (!minHeap.empty()) {
            auto [val, idx] = minHeap.top();
            minHeap.pop();
            result[idx] = val;
        }

        return result;
    }
};