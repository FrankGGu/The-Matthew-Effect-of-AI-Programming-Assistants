#include <vector>

class Solution {
public:
    int subarraysWithKDistinct(std::vector<int>& nums, int k) {
        return countAtMostK(nums, k) - countAtMostK(nums, k - 1);
    }

private:
    int countAtMostK(std::vector<int>& nums, int k) {
        if (k == 0) {
            return 0; 
        }

        int count = 0;
        int left = 0;
        int distinct_count = 0;
        std::vector<int> freq(nums.size() + 1, 0); 

        for (int right = 0; right < nums.size(); ++right) {
            if (freq[nums[right]] == 0) {
                distinct_count++;
            }
            freq[nums[right]]++;

            while (distinct_count > k) {
                freq[nums[left]]--;
                if (freq[nums[left]] == 0) {
                    distinct_count--;
                }
                left++;
            }
            count += (right - left + 1);
        }
        return count;
    }
};