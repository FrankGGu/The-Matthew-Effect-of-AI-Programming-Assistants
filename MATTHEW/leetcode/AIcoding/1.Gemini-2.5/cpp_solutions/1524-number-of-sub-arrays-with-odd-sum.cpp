#include <vector>

class Solution {
public:
    int numOfSubarrays(std::vector<int>& arr) {
        int odd_count = 0;
        int even_count = 1; // For the initial prefix sum of 0
        long long total_subarrays = 0;
        int current_sum = 0;
        const int MOD = 1e9 + 7;

        for (int num : arr) {
            current_sum += num;
            if (current_sum % 2 != 0) { // Current prefix sum is odd
                total_subarrays = (total_subarrays + even_count) % MOD;
                odd_count++;
            } else { // Current prefix sum is even
                total_subarrays = (total_subarrays + odd_count) % MOD;
                even_count++;
            }
        }
        return total_subarrays;
    }
};