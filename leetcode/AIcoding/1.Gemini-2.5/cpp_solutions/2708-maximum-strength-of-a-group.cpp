#include <vector>
#include <algorithm>
#include <limits> // Required for std::numeric_limits

class Solution {
public:
    long long maxStrength(std::vector<int>& nums) {
        std::vector<long long> positives;
        std::vector<long long> negatives;
        int zero_count = 0;

        for (int num : nums) {
            if (num > 0) {
                positives.push_back(num);
            } else if (num < 0) {
                negatives.push_back(num);
            } else {
                zero_count++;
            }
        }

        // Sort negatives to easily find the largest (closest to zero) or smallest (most negative) ones.
        // Sorted in ascending order: e.g., [-8, -5, -2]
        std::sort(negatives.begin(), negatives.end());

        // Initialize ans with the smallest possible long long value.
        // This covers cases where the maximum strength is negative (e.g., [-5]) or zero.
        long long ans = std::numeric_limits<long long>::min();

        long long current_prod = 1;
        bool has_positive_product_candidate = false; // Flag to indicate if we found any positive product.

        // Attempt to form a positive product.
        // A positive product can be formed if:
        // 1. There is at least one positive number.
        // 2. There are at least two negative numbers (to multiply into a positive).
        // If neither of these conditions is met, we cannot form a positive product from non-zero numbers.
        if (!positives.empty() || negatives.size() >= 2) {
            for (long long p : positives) {
                current_prod *= p;
            }
            for (long long n : negatives) {
                current_prod *= n;
            }

            if (negatives.size() % 2 == 0) {
                // If the count of negative numbers is even, the product of all non-zero numbers is positive.
                ans = std::max(ans, current_prod);
                has_positive_product_candidate = true;
            } else { // negatives.size() is odd
                // If the count of negative numbers is odd, the product of all non-zero numbers is negative.
                // To get a positive product, we must remove one negative number.
                // To maximize the positive product, we should remove the negative number closest to zero (negatives.back() after sorting).
                // This is only valid if, after removing a negative, we are left with a non-empty set of numbers to multiply.
                if (negatives.size() > 1 || !positives.empty()) {
                    long long temp_prod = current_prod / negatives.back();
                    ans = std::max(ans, temp_prod);
                    has_positive_product_candidate = true;
                }
            }
        }

        // Fallback logic if no positive product could be formed or considered by the above logic.
        // This scenario occurs if:
        // 1. `positives` is empty AND `negatives.size()` is 0 (e.g., `[0, 0, 0]`).
        // 2. `positives` is empty AND `negatives.size()` is 1 (e.g., `[-5]`).
        // In these specific cases, `has_positive_product_candidate` would still be false.
        if (!has_positive_product_candidate) {
            if (zero_count > 0) {
                // If there are zeros, and no positive product could be formed, the maximum strength is 0.
                // (We can always pick a single zero).
                ans = std::max(ans, 0LL);
            } else {
                // No zeros, and no positive product.
                // This implies that `positives` is empty AND `negatives.size()` is 1.
                // (If `negatives.size()` were > 1 and odd, we would have formed a positive product by removing one).
                // Example: `[-5]`. The only non-empty subsequence is `[-5]`.
                // Since `nums` is guaranteed to be non-empty, `negatives` must contain at least one element here.
                ans = std::max(ans, negatives[0]);
            }
        }

        return ans;
    }
};