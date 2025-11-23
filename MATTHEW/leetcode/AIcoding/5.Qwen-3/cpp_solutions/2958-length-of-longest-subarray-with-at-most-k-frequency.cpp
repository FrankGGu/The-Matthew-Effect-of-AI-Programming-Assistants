#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int longestSubarray(vector<int>& nums, int limit) {
        unordered_map<int, int> freq;
        int left = 0;
        int maxLen = 0;
        for (int right = 0; right < nums.size(); ++right) {
            freq[nums[right]]++;
            while (freq.rbegin()->first - freq.begin()->first > limit) {
                freq[nums[left]]--;
                if (freq[nums[left]] == 0) {
                    freq.erase(nums[left]);
                }
                left++;
            }
            maxLen = max(maxLen, right - left + 1);
        }
        return maxLen;
    }
};