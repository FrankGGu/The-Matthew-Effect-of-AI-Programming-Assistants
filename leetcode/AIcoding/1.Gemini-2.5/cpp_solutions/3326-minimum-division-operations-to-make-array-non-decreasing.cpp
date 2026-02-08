#include <vector>
#include <numeric> // For std::ceil if needed, but integer arithmetic is used

class Solution {
public:
    int minimumOperations(std::vector<int>& nums) {
        int n = nums.size();
        if (n <= 1) {
            return 0;
        }

        long long operations = 0;
        // prev_val stores the value that nums[i+1] takes after operations.
        // nums[i] must be less than or equal to prev_val.
        long long prev_val = nums[n - 1]; 

        for (int i = n - 2; i >= 0; --i) {
            long long current_num = nums[i];

            if (current_num > prev_val) {
                // We need to divide current_num to make it less than or equal to prev_val.
                // We want to find the smallest integer x such that current_num / x <= prev_val.
                // This is equivalent to x >= current_num / prev_val.
                // Using integer division, x = ceil(current_num / prev_val) can be calculated as:
                // (current_num + prev_val - 1) / prev_val for positive current_num, prev_val.
                long long x = (current_num + prev_val - 1) / prev_val;

                // If current_num > prev_val, then x will always be > 1.
                // Changing nums[i] to nums[i] / x counts as one operation.
                operations++;

                // The new value for nums[i] will be current_num / x (integer division).
                // This new value becomes the upper bound for nums[i-1].
                prev_val = current_num / x;
            } else {
                // current_num is already less than or equal to prev_val, no operation needed for nums[i].
                // The new upper bound for nums[i-1] is current_num itself.
                prev_val = current_num;
            }
        }

        return static_cast<int>(operations);
    }
};