#include <vector>

class Solution {
public:
    int identifyLargestOutlier(std::vector<int>& nums) {
        // This problem is typically interpreted as finding the single number
        // in an array that has a different parity (even or odd) than all other numbers.
        // Since there is only one such outlier, it is by definition "the largest outlier".
        // It's assumed the input array contains at least 3 elements and exactly one outlier.

        // Determine the parity of the first three elements.
        bool is_first_even = (nums[0] % 2 == 0);
        bool is_second_even = (nums[1] % 2 == 0);
        bool is_third_even = (nums[2] % 2 == 0);

        bool dominant_parity_is_even;

        // By checking the first three elements, we can establish the dominant parity.
        // At least two of these three numbers must share the same parity,
        // which will be the dominant parity of the array.
        if (is_first_even == is_second_even) {
            // If the first two have the same parity, that's the dominant one.
            dominant_parity_is_even = is_first_even;
        } else if (is_first_even == is_third_even) {
            // If the first and third have the same parity, that's the dominant one.
            dominant_parity_is_even = is_first_even;
        } else {
            // If the first is different from both the second and third,
            // then the second and third must have the same parity, which is dominant.
            dominant_parity_is_even = is_second_even;
        }

        // Iterate through the entire array to find the number that does not match
        // the determined dominant parity. This number is the outlier.
        for (int num : nums) {
            bool current_num_is_even = (num % 2 == 0);
            if (current_num_is_even != dominant_parity_is_even) {
                return num; // Found the outlier
            }
        }

        // This line should ideally not be reached given the problem constraints
        // (guaranteed to have exactly one outlier).
        return -1; 
    }
};