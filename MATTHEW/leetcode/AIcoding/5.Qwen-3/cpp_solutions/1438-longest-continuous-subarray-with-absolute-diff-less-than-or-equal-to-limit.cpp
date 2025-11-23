#include <iostream>
#include <vector>
#include <climits>
#include <algorithm>
#include <map>

class Solution {
public:
    int longestSubarray(std::vector<int>& nums, int limit) {
        std::map<int, int> minHeap;
        std::map<int, int> maxHeap;
        int left = 0;
        int result = 0;

        for (int right = 0; right < nums.size(); ++right) {
            minHeap[nums[right]]++;
            maxHeap[nums[right]]++;

            while (maxHeap.rbegin()->first - minHeap.begin()->first > limit) {
                if (minHeap[nums[left]] == 1) {
                    minHeap.erase(nums[left]);
                } else {
                    minHeap[nums[left]]--;
                }

                if (maxHeap[nums[left]] == 1) {
                    maxHeap.erase(nums[left]);
                } else {
                    maxHeap[nums[left]]--;
                }

                left++;
            }

            result = std::max(result, right - left + 1);
        }

        return result;
    }
};