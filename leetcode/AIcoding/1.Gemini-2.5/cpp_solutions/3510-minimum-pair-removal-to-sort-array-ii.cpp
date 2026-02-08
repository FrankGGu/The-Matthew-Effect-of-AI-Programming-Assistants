#include <vector>
#include <algorithm> // For std::lower_bound

class Solution {
public:
    int minimumPairRemoval(std::vector<int>& nums) {
        int n = nums.size();
        if (n == 0) {
            return 0;
        }

        std::vector<int> tails;
        for (int num : nums) {
            auto it = std::lower_bound(tails.begin(), tails.end(), num);
            if (it == tails.end()) {
                tails.push_back(num);
            } else {
                *it = num;
            }
        }

        int max_len_is = tails.size();

        // We need to remove 'k' elements, where 'k' must be even.
        // The number of remaining elements will be 'n - k'.
        // This implies that 'n - k' must have the same parity as 'n'.
        // We want to maximize the length of the remaining sorted subsequence, 'L_rem',
        // such that 'L_rem' has the same parity as 'n'.

        // 'max_len_is' is the length of the longest increasing subsequence (LIS).
        // If 'max_len_is' has the same parity as 'n', then 'n - max_len_is' is even.
        // In this case, we can keep 'max_len_is' elements.
        // The number of elements to remove is 'n - max_len_is'.
        // The number of pair removals is (n - max_len_is) / 2.

        // If 'max_len_is' has a different parity than 'n', then 'n - max_len_is' is odd.
        // We cannot keep 'max_len_is' elements because it would result in an odd number of removals.
        // To make the number of removals even, we must keep an increasing subsequence of length 'max_len_is - 1'.
        // (Note: Since n > 0, max_len_is >= 1, so max_len_is - 1 is always non-negative).
        // The length 'max_len_is - 1' will then have the same parity as 'n'.
        // The number of elements to remove is 'n - (max_len_is - 1)'.
        // The number of pair removals is (n - (max_len_is - 1)) / 2.

        if ((n - max_len_is) % 2 == 0) {
            return (n - max_len_is) / 2;
        } else {
            return (n - (max_len_is - 1)) / 2;
        }
    }
};