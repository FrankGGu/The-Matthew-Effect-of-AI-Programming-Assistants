#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long maximizeAmount(std::vector<int>& initialAmounts, int rate1, int rate2) {
        long long base_sum = 0;
        long long max1 = 0; // Largest initial amount
        long long max2 = 0; // Second largest initial amount

        for (int amount : initialAmounts) {
            base_sum += amount;
            if (amount > max1) {
                max2 = max1;
                max1 = amount;
            } else if (amount > max2) {
                max2 = amount;
            }
        }

        // Case 1: Same element chosen for both conversions (i == j)
        // The chosen element initialAmounts[k] becomes initialAmounts[k] * rate1 * rate2.
        // The gain from this element is initialAmounts[k] * (rate1 * rate2 - 1).
        // To maximize this gain, we should pick the largest initial amount (max1).
        long long gain_same_element = max1 * (1LL * rate1 * rate2 - 1);

        // Case 2: Two distinct elements chosen for conversions (i != j)
        // One element initialAmounts[i] becomes initialAmounts[i] * rate1.
        // Another element initialAmounts[j] becomes initialAmounts[j] * rate2.
        // The total gain from these two elements is initialAmounts[i] * (rate1 - 1) + initialAmounts[j] * (rate2 - 1).
        // To maximize this, we should pair the largest initial amount (max1) with the larger of (rate1 - 1, rate2 - 1),
        // and the second largest initial amount (max2) with the smaller of (rate1 - 1, rate2 - 1).
        long long gain_distinct_elements = 0;
        if (initialAmounts.size() >= 2) {
            long long r1_minus_1 = rate1 - 1;
            long long r2_minus_1 = rate2 - 1;
            gain_distinct_elements = max1 * std::max(r1_minus_1, r2_minus_1) + max2 * std::min(r1_minus_1, r2_minus_1);
        }

        // The maximum total amount is the base sum plus the maximum possible additional gain
        // from either converting the same element twice or converting two distinct elements once each.
        return base_sum + std::max(gain_same_element, gain_distinct_elements);
    }
};