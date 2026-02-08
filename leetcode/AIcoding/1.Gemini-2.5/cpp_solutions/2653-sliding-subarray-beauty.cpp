#include <vector>
#include <numeric> // For std::iota if needed, but not for this solution

class Solution {
public:
    std::vector<int> getSubarrayBeauty(std::vector<int>& nums, int k, int x) {
        std::vector<int> result;
        std::vector<int> counts(101, 0); // Frequencies for numbers -50 to 50. Index i maps to value i-50.

        // Helper to find the x-th smallest element in the current window
        auto findXthSmallest = [&](int target_x) {
            int current_count = 0;
            for (int i = 0; i < 101; ++i) {
                current_count += counts[i];
                if (current_count >= target_x) {
                    return i - 50; // Convert index back to original value
                }
            }
            return 0; // Should not be reached if k >= x and nums are within range
        };

        // Initialize the first window
        for (int i = 0; i < k; ++i) {
            counts[nums[i] + 50]++;
        }

        int beauty = findXthSmallest(x);
        result.push_back((beauty < 0) ? beauty : 0);

        // Slide the window
        for (int i = k; i < nums.size(); ++i) {
            // Remove the element leaving the window
            counts[nums[i - k] + 50]--;
            // Add the element entering the window
            counts[nums[i] + 50]++;

            beauty = findXthSmallest(x);
            result.push_back((beauty < 0) ? beauty : 0);
        }

        return result;
    }
};