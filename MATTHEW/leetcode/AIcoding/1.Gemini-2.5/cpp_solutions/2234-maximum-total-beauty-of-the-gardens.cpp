#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    long long maximumBeauty(std::vector<int>& flowers, long long newFlowers, int target, int full, int partial) {
        int n = flowers.size();

        std::sort(flowers.begin(), flowers.end());

        std::vector<long long> prefix_sum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix_sum[i + 1] = prefix_sum[i] + flowers[i];
        }

        long long max_total_beauty = 0;
        long long current_cost_for_complete = 0;

        // Iterate k (number of gardens to make complete) from 0 to n.
        // The k gardens chosen for completion are the largest ones: flowers[n-k], ..., flowers[n-1].
        // The remaining n-k gardens are flowers[0], ..., flowers[n-k-1].
        for (int k = 0; k <= n; ++k) {
            // Update current_cost_for_complete for this k.
            // When k increases, we consider making flowers[n-k] complete.
            // For k=0, cost is 0.
            if (k > 0) {
                current_cost_for_complete += std::max(0LL, (long long)target - flowers[n - k]);
            }

            if (current_cost_for_complete > newFlowers) {
                break; // Cannot afford to make k gardens complete.
            }

            long long remaining_flowers = newFlowers - current_cost_for_complete;

            // Now consider the n-k incomplete gardens: flowers[0], ..., flowers[n-k-1].
            // We want to maximize their minimum beauty using remaining_flowers.
            long long current_min_beauty_for_incomplete = 0;

            int num_incomplete = n - k;
            if (num_incomplete > 0) {
                // Binary search for the maximum possible minimum beauty (min_b) for incomplete gardens.
                // Range for min_b: [0, target - 1].
                long long low_min_b = 0, high_min_b = target - 1;
                long long ans_min_b = 0;

                while (low_min_b <= high_min_b) {
                    long long mid_min_b = low_min_b + (high_min_b - low_min_b) / 2;

                    // Check if it's possible to make all num_incomplete gardens at least mid_min_b.
                    // Find how many gardens are below mid_min_b among flowers[0...num_incomplete-1].
                    auto it = std::upper_bound(flowers.begin(), flowers.begin() + num_incomplete, mid_min_b);
                    int count_below_mid = it - flowers.begin(); // Number of gardens < mid_min_b

                    // Cost to raise gardens below mid_min_b to mid_min_b.
                    // This is sum(mid_min_b - flowers[i]) for i from 0 to count_below_mid-1.
                    long long cost_to_raise_incomplete = (long long)count_below_mid * mid_min_b - prefix_sum[count_below_mid];

                    if (cost_to_raise_incomplete <= remaining_flowers) {
                        ans_min_b = mid_min_b;
                        low_min_b = mid_min_b + 1;
                    } else {
                        high_min_b = mid_min_b - 1;
                    }
                }
                current_min_beauty_for_incomplete = ans_min_b;
            }

            // Calculate total beauty for this k.
            long long current_total_beauty = (long long)k * full;
            if (num_incomplete > 0) { // Only add partial score if there are incomplete gardens.
                current_total_beauty += current_min_beauty_for_incomplete * partial;
            }

            max_total_beauty = std::max(max_total_beauty, current_total_beauty);
        }

        return max_total_beauty;
    }
};