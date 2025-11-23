#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int maxSubarrayLength(std::vector<int>& nums, int k) {
        int n = nums.size();
        if (n == 0) {
            return 0;
        }

        std::unordered_map<int, int> freq;
        int left = 0;
        int max_len = 0;

        for (int right = 0; right < n; ++right) {
            freq[nums[right]]++;

            while (freq[nums[right]] > k) {
                freq[nums[left]]--;
                left++;
            }

            max_len = std::max(max_len, right - left + 1);
        }

        return max_len;
    }
};