#include <vector>
#include <numeric>
#include <algorithm>
#include <cmath>

class Solution {
public:
    bool check(long long max_products_per_store, int n, const std::vector<int>& quantities) {
        if (max_products_per_store == 0) return false; // Should not happen with low=1
        long long stores_needed = 0;
        for (int q : quantities) {
            stores_needed += (q + max_products_per_store - 1) / max_products_per_store;
            if (stores_needed > n) { // Optimization: if we already exceed n, no need to check further
                return false;
            }
        }
        return stores_needed <= n;
    }

    int minimizedMaximum(int n, std::vector<int>& quantities) {
        long long low = 1;
        long long high = 0;
        for (int q : quantities) {
            if (q > high) {
                high = q;
            }
        }

        long long ans = high;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            if (check(mid, n, quantities)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return static_cast<int>(ans);
    }
};