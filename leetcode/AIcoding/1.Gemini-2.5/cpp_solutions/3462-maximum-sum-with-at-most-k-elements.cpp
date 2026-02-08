#include <vector>
#include <algorithm> // Required for std::max_element

class Solution {
public:
    int maximizeSum(std::vector<int>& nums, int k) {
        // Find the maximum element in the array.
        // This is the starting value for our operations.
        int max_val = *std::max_element(nums.begin(), nums.end());

        // The strategy is to always pick the largest available number.
        // If we pick 'm', our score increases by 'm', and 'm + 1' is added back to the array.
        // This means the numbers we pick will be:
        // max_val, max_val + 1, max_val + 2, ..., max_val + (k - 1)
        // We need to sum these 'k' numbers.

        // The sum of an arithmetic series is n/2 * (first_term + last_term).
        // Here, n = k, first_term = max_val, last_term = max_val + (k - 1).
        // Sum = k * (max_val + (max_val + k - 1)) / 2
        // Sum = k * (2 * max_val + k - 1) / 2

        // Alternatively, we can see this as:
        // (max_val + max_val + ... + max_val) (k times) + (0 + 1 + 2 + ... + (k - 1))
        // = k * max_val + (k * (k - 1) / 2)

        long long total_score = (long long)k * max_val + (long long)k * (k - 1) / 2;

        return static_cast<int>(total_score);
    }
};