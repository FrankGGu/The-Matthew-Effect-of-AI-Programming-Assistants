#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    long long kSum(vector<int>& nums, int k) {
        vector<long long> prefix(nums.size() + 1);
        for (int i = 0; i < nums.size(); ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        priority_queue<long long> maxHeap;
        for (int i = 0; i < nums.size(); ++i) {
            for (int j = i + 1; j <= nums.size(); ++j) {
                long long sum = prefix[j] - prefix[i];
                if (maxHeap.size() < k) {
                    maxHeap.push(sum);
                } else if (sum < maxHeap.top()) {
                    maxHeap.pop();
                    maxHeap.push(sum);
                }
            }
        }

        long long result = 0;
        while (!maxHeap.empty()) {
            result += maxHeap.top();
            maxHeap.pop();
        }

        return result;
    }
};