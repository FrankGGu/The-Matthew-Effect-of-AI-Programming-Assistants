#include <vector>
#include <numeric> // For std::accumulate if needed, but manual loop is fine for sliding window

class Solution {
public:
    std::vector<long long> getPower(std::vector<int>& nums, int k) {
        std::vector<long long> result;
        if (nums.empty() || k == 0 || k > nums.size()) {
            return result;
        }

        long long current_sum = 0;

        // Calculate the sum for the first window
        for (int i = 0; i < k; ++i) {
            current_sum += nums[i];
        }
        result.push_back(current_sum);

        // Slide the window
        for (int i = k; i < nums.size(); ++i) {
            current_sum -= nums[i - k]; // Remove the element leaving the window
            current_sum += nums[i];     // Add the element entering the window
            result.push_back(current_sum);
        }

        return result;
    }
};