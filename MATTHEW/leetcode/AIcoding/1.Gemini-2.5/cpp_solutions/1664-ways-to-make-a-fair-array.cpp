#include <vector>
#include <numeric>

class Solution {
public:
    int waysToMakeFair(std::vector<int>& nums) {
        int n = nums.size();
        if (n == 0) {
            return 0;
        }

        std::vector<long long> prefix_even(n + 1, 0);
        std::vector<long long> prefix_odd(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            prefix_even[i+1] = prefix_even[i];
            prefix_odd[i+1] = prefix_odd[i];
            if (i % 2 == 0) { // Current index is even
                prefix_even[i+1] += nums[i];
            } else { // Current index is odd
                prefix_odd[i+1] += nums[i];
            }
        }

        std::vector<long long> suffix_even(n + 1, 0);
        std::vector<long long> suffix_odd(n + 1, 0);

        for (int i = n - 1; i >= 0; --i) {
            suffix_even[i] = suffix_even[i+1];
            suffix_odd[i] = suffix_odd[i+1];
            if (i % 2 == 0) { // Current index is even
                suffix_even[i] += nums[i];
            } else { // Current index is odd
                suffix_odd[i] += nums[i];
            }
        }

        int fair_arrays_count = 0;
        for (int i = 0; i < n; ++i) {
            // Sum of even-indexed elements in the array after removing nums[i]
            // This includes even-indexed elements before i (prefix_even[i])
            // and odd-indexed elements after i (suffix_odd[i+1]), which become even-indexed
            long long current_even_sum = prefix_even[i] + suffix_odd[i+1];

            // Sum of odd-indexed elements in the array after removing nums[i]
            // This includes odd-indexed elements before i (prefix_odd[i])
            // and even-indexed elements after i (suffix_even[i+1]), which become odd-indexed
            long long current_odd_sum = prefix_odd[i] + suffix_even[i+1];

            if (current_even_sum == current_odd_sum) {
                fair_arrays_count++;
            }
        }

        return fair_arrays_count;
    }
};