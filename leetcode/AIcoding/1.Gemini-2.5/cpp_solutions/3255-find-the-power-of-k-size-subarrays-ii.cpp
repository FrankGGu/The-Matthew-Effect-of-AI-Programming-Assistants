#include <vector>
#include <unordered_map>

class Solution {
public:
    // Assuming "Power" of a subarray is defined as the sum of (frequency of x in window)^2 * x
    // for each distinct x in the window.
    std::vector<long long> findThePowerOfKSizeSubarraysII(std::vector<int>& nums, int k) {
        std::vector<long long> result;
        if (nums.empty() || k <= 0 || k > nums.size()) {
            return result;
        }

        std::unordered_map<int, int> freq_map;
        long long current_power = 0;

        // Initialize the first window
        for (int i = 0; i < k; ++i) {
            int x = nums[i];
            // Subtract old contribution of x (if x was already present)
            current_power -= (long long)freq_map[x] * freq_map[x] * x;

            // Increment frequency
            freq_map[x]++;

            // Add new contribution of x
            current_power += (long long)freq_map[x] * freq_map[x] * x;
        }
        result.push_back(current_power);

        // Slide the window
        for (int i = k; i < nums.size(); ++i) {
            // Remove the element leaving the window (nums[i-k])
            int left_val = nums[i - k];
            current_power -= (long long)freq_map[left_val] * freq_map[left_val] * left_val;
            freq_map[left_val]--;
            current_power += (long long)freq_map[left_val] * freq_map[left_val] * left_val;

            // Add the element entering the window (nums[i])
            int right_val = nums[i];
            current_power -= (long long)freq_map[right_val] * freq_map[right_val] * right_val;
            freq_map[right_val]++;
            current_power += (long long)freq_map[right_val] * freq_map[right_val] * right_val;

            result.push_back(current_power);
        }

        return result;
    }
};