#include <vector>
#include <cmath>
#include <numeric>
#include <algorithm>

class Solution {
public:
    bool check(int speed, const std::vector<int>& dist, double hour) {
        double total_time = 0.0;
        int n = dist.size();

        for (int i = 0; i < n - 1; ++i) {
            total_time += std::ceil(static_cast<double>(dist[i]) / speed);
        }
        total_time += static_cast<double>(dist[n - 1]) / speed;

        return total_time <= hour;
    }

    int minSpeedOnTime(std::vector<int>& dist, double hour) {
        int n = dist.size();

        // Edge case: If there's more than one train (n > 1), each of the first n-1 trains
        // must take at least 1 hour due to the ceiling function.
        // So, the minimum time for the first n-1 trains is n-1 hours.
        // If the total allowed hour is less than or equal to n-1, it's impossible
        // for dist[n-1] > 0, as the last train would need to take non-positive time.
        // Since dist[i] >= 1, dist[n-1] is always > 0.
        // For example, if n=3, hour=2.0, the first two trains take at least 1+1=2 hours.
        // This leaves 0 hours for the third train, which is impossible.
        if (n > 1 && hour <= static_cast<double>(n - 1)) {
            return -1;
        }

        int left = 1;
        // The maximum possible speed could be very large.
        // For example, if dist = [1], hour = 0.0000000001 (not possible as hour >= 1).
        // If dist = [1, 10^5], hour = 1.0000000001, then speed could be 10^10.
        // Since the return type is int, the maximum possible speed is INT_MAX (approx 2 * 10^9).
        // If the required speed exceeds this, it's considered impossible, and -1 should be returned.
        // So, we set the right bound to a value within int limits.
        int right = 2000000000; // A safe upper bound for int speed (less than INT_MAX).

        int ans = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (check(mid, dist, hour)) {
                ans = mid;
                right = mid - 1; // Try to find a smaller speed
            } else {
                left = mid + 1;  // Need a larger speed
            }
        }

        return ans;
    }
};