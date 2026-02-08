#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int maxSubarrays(std::vector<int>& nums) {
        // The problem requires splitting the array into the maximum number of subarrays
        // such that the bitwise AND of all elements in each subarray is strictly greater than 0.

        // If any element 'x' in 'nums' is 0, then any subarray containing 'x' will have
        // a bitwise AND of 0 (since 'A & 0 = 0' for any 'A').
        // This violates the condition that the bitwise AND must be strictly greater than 0.
        // Since the entire array must be split into these subarrays, if a 0 exists,
        // it's impossible to satisfy the condition for the subarray that contains it.
        // Therefore, if 'nums' contains any 0, no valid split can be made.
        // In this case, the maximum number of subarrays is 0.
        for (int x : nums) {
            if (x == 0) {
                return 0;
            }
        }

        // If the loop completes, it means no element in 'nums' is 0.
        // This implies all elements 'nums[i]' are strictly greater than 0.
        // In this scenario, we can split the array into 'n' subarrays, where 'n' is the size of 'nums'.
        // Each subarray will consist of a single element: [nums[0]], [nums[1]], ..., [nums[n-1]].
        // For each such single-element subarray [nums[i]], its bitwise AND is simply nums[i].
        // Since we've established that all nums[i] > 0, the condition "bitwise AND > 0" is satisfied for every single-element subarray.
        // 'n' is the maximum possible number of subarrays we can form from an array of size 'n'.
        // Thus, if no 0 is present, the answer is 'n'.
        return nums.size();
    }
};