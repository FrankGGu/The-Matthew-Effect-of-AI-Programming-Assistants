#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minimumDifference(vector<int>& nums) {
        int n = nums.size();
        long long total = 0;
        for (int num : nums) {
            total += num;
        }

        priority_queue<int> maxHeap;
        priority_queue<long long, vector<long long>, greater<long long>> minHeap;

        long long sumLeft = 0;
        long long sumRight = 0;

        for (int i = 0; i < n / 2; ++i) {
            maxHeap.push(nums[i]);
            sumLeft += nums[i];
        }

        for (int i = n / 2; i < n; ++i) {
            minHeap.push(nums[i]);
            sumRight += nums[i];
        }

        long long diff = abs(sumLeft - sumRight);

        for (int i = n / 2; i < n; ++i) {
            if (maxHeap.empty() || nums[i] > maxHeap.top()) {
                int val = maxHeap.top();
                maxHeap.pop();
                sumLeft -= val;
                sumLeft += nums[i];
                maxHeap.push(nums[i]);
            } else {
                long long val = minHeap.top();
                minHeap.pop();
                sumRight -= val;
                sumRight += nums[i];
                minHeap.push(nums[i]);
            }
            diff = min(diff, abs(sumLeft - sumRight));
        }

        return diff;
    }
};