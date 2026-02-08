#include <vector>
#include <cmath>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long repairCars(std::vector<int>& ranks, int cars) {
        long long low = 1;
        long long high = 1LL * (*std::min_element(ranks.begin(), ranks.end())) * cars * cars;
        long long ans = high;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            long long repaired_count = 0;
            for (int r : ranks) {
                repaired_count += static_cast<long long>(sqrt(mid / r));
            }

            if (repaired_count >= cars) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }
};