#include <vector>
#include <numeric>
#include <unordered_set>

class Solution {
public:
    bool splitArraySameAverage(std::vector<int>& nums) {
        int n = nums.size();
        if (n == 1) {
            return false;
        }

        int totalSum = std::accumulate(nums.begin(), nums.end(), 0);

        // Optimization: Transform the problem.
        // We are looking for a subset A with sumA and length lenA such that
        // sumA / lenA == totalSum / n.
        // This is equivalent to sumA * n == totalSum * lenA.
        // Let's create a new array `transformed_nums` where each element is `nums[i] * n - totalSum`.
        // If we find a subset of `transformed_nums` of length `lenA` that sums to 0,
        // then sum(transformed_nums[i] for i in A) = sum(nums[i]*n - totalSum for i in A)
        // = n * sumA - lenA * totalSum.
        // If this sum is 0, then n * sumA = lenA * totalSum, which is our condition.
        // We need to find such a subset A that is non-empty and not the entire array (1 <= lenA < n).
        for (int i = 0; i < n; ++i) {
            nums[i] = nums[i] * n - totalSum;
        }

        // Use meet-in-the-middle approach.
        // Split the array into two halves.
        int n1 = n / 2;
        int n2 = n - n1;

        // sums_left[k] will store all possible sums using 'k' elements from the first half of `nums`.
        // Using unordered_set for efficient lookups and to handle potentially negative sums.
        std::vector<std::unordered_set<int>> sums_left(n1 + 1);
        sums_left[0].insert(0); // Base case: 0 elements sum to 0

        // Generate sums for the first half
        for (int i = 0; i < n1; ++i) {
            int num = nums[i];
            // Iterate k downwards to ensure each element is used at most once for a given subset
            for (int k = i; k >= 0; --k) {
                for (int s : sums_left[k]) {
                    sums_left[k + 1].insert(s + num);
                }
            }
        }

        // sums_right[k] will store all possible sums using 'k' elements from the second half of `nums`.
        std::vector<std::unordered_set<int>> sums_right(n2 + 1);
        sums_right[0].insert(0); // Base case: 0 elements sum to 0

        // Generate sums for the second half
        for (int i = 0; i < n2; ++i) {
            int num = nums[n1 + i]; // Elements from the second half
            // Iterate k downwards
            for (int k = i; k >= 0; --k) {
                for (int s : sums_right[k]) {
                    sums_right[k + 1].insert(s + num);
                }
            }
        }

        // Now combine sums from both halves.
        // We are looking for a subset of length `k_total` (1 <= k_total < n) that sums to 0.
        // This means we need s_left + s_right = 0, or s_right = -s_left.
        for (int k_total = 1; k_total < n; ++k_total) { // k_total is the length of subset A
            for (int k_left = 0; k_left <= n1; ++k_left) { // k_left is length of A's part from first half
                int k_right = k_total - k_left; // k_right is length of A's part from second half

                // Check if k_right is a valid length for the second half
                if (k_right < 0 || k_right > n2) {
                    continue;
                }

                // Iterate through all sums from the left part
                for (int s_left : sums_left[k_left]) {
                    // Check if the complementary sum exists in the right part
                    if (sums_right[k_right].count(-s_left)) {
                        return true;
                    }
                }
            }
        }

        return false;
    }
};