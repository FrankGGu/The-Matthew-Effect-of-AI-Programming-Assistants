#include <vector>
#include <unordered_map>

class Solution {
public:
    long long count_at_most_k_pairs(std::vector<int>& nums, int target_pairs) {
        if (target_pairs < 0) {
            return 0;
        }

        long long ans = 0;
        int left = 0;
        long long current_pairs = 0;
        std::vector<int> freq(100001, 0); 

        for (int right = 0; right < nums.size(); ++right) {
            int num_r = nums[right];
            current_pairs += freq[num_r];
            freq[num_r]++;

            while (current_pairs > target_pairs) {
                int num_l = nums[left];
                freq[num_l]--;
                current_pairs -= freq[num_l]; 
                left++;
            }
            ans += (right - left + 1);
        }
        return ans;
    }

    long long numberOfGoodSubarrays(std::vector<int>& nums, int k) {
        return count_at_most_k_pairs(nums, k) - count_at_most_k_pairs(nums, k - 1);
    }
};