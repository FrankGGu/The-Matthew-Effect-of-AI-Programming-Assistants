#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    // Helper function to check if a given maximum value 'x' is achievable
    // 'p' is a vector to store the number of operations performed on each road.
    // 'total_ops_used_initial' is the sum of initial operations p[0] and p[1].
    bool try_config(std::vector<long long>& p, long long x, int n, const std::vector<int>& roads, long long k, long long& total_ops_used) {
        if (total_ops_used > k) {
            return false;
        }

        // Greedily determine p[i] for i = 2 to n-1.
        // p[i] is chosen to satisfy roads[i-2] <= x.
        // The value of roads[i-2] is roads[i-2] - 2*p[i-2] + p[(i-3+n)%n] + p[(i-1+n)%n].
        // We need this value to be <= x.
        // p[i-2] is the number of operations on road (i-2).
        // p[(i-3+n)%n] and p[(i-1+n)%n] are already determined (either fixed by outer loops or by previous iterations).
        for (int i = 2; i < n; ++i) {
            // Calculate the current value of roads[i-2] if p[i-2] was 0
            long long current_val_at_i_minus_2 = (long long)roads[i-2] + p[(i-3+n)%n] + p[(i-1+n)%n];

            // We need to perform operations on road (i-2) to reduce its value.
            // Each operation on road (i-2) reduces its value by 2.
            // So, 2 * needed_ops_on_i_minus_2 >= current_val_at_i_minus_2 - x
            long long needed_ops_on_i_minus_2 = std::max(0LL, (current_val_at_i_minus_2 - x + 1) / 2);

            p[i-2] += needed_ops_on_i_minus_2; // Add to existing p[i-2] (which was 0 if i-2 > 1, or p0_val/p1_val if i-2 is 0 or 1)
            total_ops_used += needed_ops_on_i_minus_2;
            if (total_ops_used > k) {
                return false; // Exceeded k operations
            }
        }

        // After the loop, p[0]...p[n-1] are determined.
        // p[0] and p[1] were fixed by the outer loops.
        // p[2] through p[n-1] were determined by the inner loop.
        // Now verify that all roads (0 to n-1) satisfy the condition.
        bool possible = true;
        for (int i = 0; i < n; ++i) {
            long long final_val = (long long)roads[i] - 2 * p[i] + p[(i - 1 + n) % n] + p[(i + 1) % n];
            if (final_val > x) {
                possible = false;
                break;
            }
        }
        return possible;
    }

    // Main check function for binary search
    bool check(long long x, int n, const std::vector<int>& roads, long long k) {
        if (n == 1) {
            // For n=1, an operation on road 0 means roads[0] -= 2, roads[0] += 1, roads[0] += 1.
            // So roads[0] remains unchanged. Thus, if n=1, roads[0] must be <= x initially.
            return roads[0] <= x;
        }

        // Due to circular dependencies, we need to try different initial values for p[0] and p[1].
        // It's sufficient to try p[0] = 0 or 1, and p[1] = 0 or 1.
        for (int p0_val = 0; p0_val <= 1; ++p0_val) {
            for (int p1_val = 0; p1_val <= 1; ++p1_val) {
                std::vector<long long> p(n); // p[i] is the number of operations on road i
                p[0] = p0_val;
                p[1] = p1_val;
                long long current_total_ops = p[0] + p[1];

                if (try_config(p, x, n, roads, k, current_total_ops)) {
                    return true;
                }
            }
        }
        return false;
    }

    int minimizeMax(std::vector<int>& roads, int k) {
        int n = roads.size();
        long long low = 0;
        long long high = 0;
        for (int r : roads) {
            high = std::max(high, (long long)r);
        }
        // The maximum possible value for any road could increase if all k operations
        // are performed on its neighbors. Each operation on a neighbor increases
        // the current road by 1. So, at most 2*k increase.
        high += 2LL * k; 

        long long ans = high; // Initialize with a worst-case possible maximum

        // Binary search for the minimum possible maximum value
        while (low <= high) {
            long long mid = low + (high - low) / 2;
            if (check(mid, n, roads, k)) {
                ans = mid;
                high = mid - 1; // Try to achieve an even smaller maximum
            } else {
                low = mid + 1; // Need a larger maximum
            }
        }
        return ans;
    }
};