#include <vector>
#include <cmath> // For std::abs if needed, though for positive k, it's not strictly necessary for the optimized solution.
                 // For the brute force, it's used as |nums[i] - nums[j]|.

class Solution {
public:
    int countKDifference(std::vector<int>& nums, int k) {
        // Since nums[i] are between 1 and 100, we can use a frequency array.
        // The size 101 covers indices 0 to 100.
        std::vector<int> freq(101, 0);
        int count = 0;

        // Iterate through each number in the input array
        for (int num : nums) {
            // For the current 'num', we are looking for previously seen numbers 'x' such that |num - x| == k.
            // This means x = num - k OR x = num + k.

            // Check if 'num - k' exists among previously processed numbers.
            // Ensure 'num - k' is within the valid range [1, 100].
            if (num - k >= 1) {
                count += freq[num - k];
            }

            // Check if 'num + k' exists among previously processed numbers.
            // Ensure 'num + k' is within the valid range [1, 100].
            if (num + k <= 100) {
                count += freq[num + k];
            }

            // Increment the frequency of the current number.
            freq[num]++;
        }

        return count;
    }
};