#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    long long kSum(vector<int>& nums, int k) {
        long long sum = 0;
        for (int num : nums) {
            sum += abs(num);
        }

        priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<>> minHeap;
        minHeap.push({sum, 0});

        while (k-- > 1 && !minHeap.empty()) {
            auto [currentSum, index] = minHeap.top();
            minHeap.pop();

            if (index >= nums.size()) continue;

            long long newSum = currentSum - 2 * abs(nums[index]);
            minHeap.push({newSum, index + 1});

            if (index + 1 < nums.size()) {
                newSum = currentSum - 2 * abs(nums[index]) + 2 * abs(nums[index + 1]);
                minHeap.push({newSum, index + 1});
            }
        }

        return minHeap.top().first;
    }
};