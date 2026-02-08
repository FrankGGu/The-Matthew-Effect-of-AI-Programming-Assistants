#include <vector>
#include <numeric>
#include <algorithm>
#include <cmath>

class Solution {
public:
    int cutBamboo(std::vector<int>& bamboo_len, int k) {
        long long low = 1, high = 0;
        for (int len : bamboo_len) {
            if (len > high) {
                high = len;
            }
        }

        long long ans = high;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            if (mid == 0) {
                low = 1;
                continue;
            }
            if (check(mid, bamboo_len, k)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return static_cast<int>(ans);
    }

private:
    bool check(long long x, const std::vector<int>& bamboo_len, long long k_limit) {
        long long total_ops = 0;
        for (int len : bamboo_len) {
            long long current_len = len;
            if (current_len <= x) {
                continue;
            }

            long long num_ops = 0;
            while (current_len > x) {
                current_len = static_cast<long long>(sqrt(current_len));
                num_ops++;
            }
            total_ops += num_ops;

            if (total_ops > k_limit) {
                return false;
            }
        }
        return true;
    }
};