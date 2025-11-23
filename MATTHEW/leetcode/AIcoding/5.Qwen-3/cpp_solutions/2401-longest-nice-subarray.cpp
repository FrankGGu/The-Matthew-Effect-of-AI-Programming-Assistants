#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int longestNiceSubarray(vector<int>& nums) {
        int n = nums.size();
        int maxLen = 0;
        int left = 0;
        unordered_set<int> seen;

        for (int right = 0; right < n; ++right) {
            while (seen.find(nums[right]) != seen.end()) {
                seen.erase(nums[left]);
                ++left;
            }
            seen.insert(nums[right]);
            maxLen = max(maxLen, right - left + 1);
        }

        return maxLen;
    }
};