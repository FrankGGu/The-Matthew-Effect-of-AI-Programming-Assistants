#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long storeWater(std::vector<int>& bucket, std::vector<int>& vat) {
        int n = bucket.size();
        int max_v = 0;
        for (int v : vat) {
            max_v = std::max(max_v, v);
        }

        if (max_v == 0) {
            return 0;
        }

        long long min_total_ops = -1; // Use -1 as an indicator for not yet set, or LLONG_MAX

        // Initialize min_total_ops with a very large value.
        min_total_ops = -1; // Will be set in the first iteration.

        // Iterate k (number of refills) from 1 up to max_v.
        // The loop is pruned by `k >= min_total_ops`.
        // This pruning step is crucial for performance.
        // If `min_total_ops` is already found to be small,
        // then `k` will not iterate very far beyond `min_total_ops`.
        // The maximum value `k` will reach is `min(max_v, actual_optimal_cost)`.
        for (int k = 1; k <= max_v; ++k) {
            long long current_ops = k;
            for (int i = 0; i < n; ++i) {
                if (vat[i] == 0) {
                    continue;
                }
                // Calculate required initial water for bucket[i] such that required_initial_water * k >= vat[i]
                // This is ceil(vat[i] / k)
                long long required_initial_water = (vat[i] + k - 1) / k;

                // Add operations to increase bucket[i] if needed
                current_ops += std::max(0LL, required_initial_water - bucket[i]);
            }

            // Update the minimum total operations found so far
            if (min_total_ops == -1 || current_ops < min_total_ops) {
                min_total_ops = current_ops;
            }

            // Pruning: If the current value of k alone is already greater than or equal to
            // the best total operations found so far, then any further increase in k
            // (which also increases current_ops because k is part of it and bucket operations are non-negative)
            // will not yield a better result. So, we can break the loop.
            if (k >= min_total_ops) {
                break;
            }
        }

        return min_total_ops;
    }
};