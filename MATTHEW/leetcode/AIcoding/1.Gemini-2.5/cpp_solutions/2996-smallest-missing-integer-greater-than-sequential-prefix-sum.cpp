#include <vector>
#include <unordered_set>

class Solution {
public:
    int smallestMissingInteger(std::vector<int>& nums) {
        // Step 1: Calculate the sequential prefix sum.
        // This is defined as the sum of the longest prefix of `nums`
        // that forms a strictly increasing sequence with a step of 1,
        // starting from `nums[0]`.
        // Example: nums = [1, 2, 3, 5, 4] -> sequential prefix sum = 1 + 2 + 3 = 6
        // Example: nums = [3, 4, 5, 1, 2] -> sequential prefix sum = 3 + 4 + 5 = 12
        // We assume the sum and the final result will fit within `int` limits,
        // as is typical for LeetCode problems returning `int`.

        int prefix_sum = nums[0]; 

        for (int i = 1; i < nums.size(); ++i) {
            if (nums[i] == nums[i-1] + 1) {
                prefix_sum += nums[i];
            } else {
                break; // The sequential prefix ends here
            }
        }

        // Step 2: Store all numbers from the entire `nums` array into a hash set
        // for efficient O(1) average time lookup.
        std::unordered_set<int> seen_numbers;
        for (int num : nums) {
            seen_numbers.insert(num);
        }

        // Step 3: Find the smallest missing integer strictly greater than the `prefix_sum`.
        // The phrasing "Greater Than" typically implies a strict inequality (X > Y)
        // in LeetCode problem statements unless "or equal to" is explicitly mentioned.
        // Thus, we start checking from `prefix_sum + 1`.

        int missing_int = prefix_sum + 1; 

        // Increment `missing_int` until we find a value that is not present in `seen_numbers`.
        while (seen_numbers.count(missing_int)) {
            missing_int++;
        }

        return missing_int;
    }
};