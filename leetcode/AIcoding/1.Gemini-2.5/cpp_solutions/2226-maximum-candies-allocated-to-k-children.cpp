#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    bool can_allocate(long long x, const std::vector<int>& candies, long long k) {
        if (x == 0) {
            return true;
        }
        long long total_children_served = 0;
        for (int pile : candies) {
            total_children_served += pile / x;
            if (total_children_served >= k) {
                return true;
            }
        }
        return total_children_served >= k;
    }

    int maximumCandies(std::vector<int>& candies, long long k) {
        long long low = 0;
        long long high = 0;
        for (int pile : candies) {
            if (pile > high) {
                high = pile;
            }
        }

        long long ans = 0;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            if (can_allocate(mid, candies, k)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return static_cast<int>(ans);
    }
};