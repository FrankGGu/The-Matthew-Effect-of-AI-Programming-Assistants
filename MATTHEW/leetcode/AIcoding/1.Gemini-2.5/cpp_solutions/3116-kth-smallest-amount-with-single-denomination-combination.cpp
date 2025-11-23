#include <vector>
#include <numeric>
#include <algorithm>

long long gcd(long long a, long long b) {
    while (b) {
        a %= b;
        std::swap(a, b);
    }
    return a;
}

long long count_amounts(long long limit, const std::vector<int>& denominations) {
    int n = denominations.size();
    long long total_count = 0;

    // Iterate through all non-empty subsets of denominations
    for (int i = 1; i < (1 << n); ++i) {
        long long current_lcm = 1;
        int num_elements = 0;
        bool overflowed = false; // Flag to indicate if current_lcm has effectively exceeded 'limit'

        // Calculate LCM for the current subset of denominations
        for (int j = 0; j < n; ++j) {
            if ((i >> j) & 1) { // If j-th denomination is in the current subset
                num_elements++;

                if (overflowed) { // If LCM already overflowed/exceeded limit, no need to calculate further
                    continue;
                }

                long long common_divisor = gcd(current_lcm, denominations[j]);
                long long val_after_div = current_lcm / common_divisor;

                // Check for potential overflow or if the LCM will exceed 'limit'
                // We want to compute val_after_div * denominations[j].
                // If val_after_div > limit / denominations[j], then the product will exceed 'limit'.
                // This check avoids both overflow of current_lcm and exceeding 'limit'.
                // Since denominations[j] >= 1, limit / denominations[j] is well-defined.
                if (val_after_div > limit / denominations[j]) {
                    overflowed = true;
                } else {
                    current_lcm = val_after_div * denominations[j];
                }
            }
        }

        if (overflowed) {
            // This subset's LCM is effectively infinite (or > limit), so it contributes 0 to the count.
            continue;
        }

        // Apply inclusion-exclusion principle based on the number of elements in the subset
        if (num_elements % 2 == 1) { // Odd number of elements: add to total_count
            total_count += limit / current_lcm;
        } else { // Even number of elements: subtract from total_count
            total_count -= limit / current_lcm;
        }
    }
    return total_count;
}

class Solution {
public:
    long long kthSmallestAmount(std::vector<int>& denominations, int k) {
        // Sort denominations and remove duplicates.
        // This optimizes the inclusion-exclusion by reducing 'n' and ensures distinct values.
        std::sort(denominations.begin(), denominations.end());
        denominations.erase(std::unique(denominations.begin(), denominations.end()), denominations.end());

        // Binary search for the Kth smallest amount.
        // The search space for the amount 'x' is [1, max_possible_amount].
        // Smallest possible amount is 1.
        long long low = 1;
        // Maximum possible amount: if k=10^9 and min(denominations)=10^5,
        // then the k-th amount could be around 10^9 * 10^5 = 10^14.
        // A safe upper bound is 2 * 10^14.
        long long high = 200000000000000LL; // 2 * 10^14

        long long ans = high; // Initialize with a value that will be updated

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            // Check if there are at least 'k' amounts less than or equal to 'mid'.
            if (count_amounts(mid, denominations) >= k) {
                ans = mid;       // 'mid' is a possible answer, try for a smaller one.
                high = mid - 1;
            } else {
                low = mid + 1;   // 'mid' is too small, need a larger amount.
            }
        }
        return ans;
    }
};