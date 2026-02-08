#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long maxPower(std::vector<int>& stations, int r, long long k) {
        int n = stations.size();
        long long low = 0;
        long long high = 0;
        for (int s : stations) {
            high += s;
        }
        high += k;

        long long ans = 0;
        while (low <= high) {
            long long mid = low + (high - low) / 2;
            if (check(stations, r, k, mid, n)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans;
    }

private:
    bool check(const std::vector<int>& stations, int r, long long k, long long min_power, int n) {
        std::vector<long long> initial_power(n);
        long long current_sum = 0;
        for (int i = 0; i < n; ++i) {
            if (i == 0) {
                for (int j = 0; j <= r && j < n; ++j) {
                    current_sum += stations[j];
                }
            } else {
                if (i + r < n) {
                    current_sum += stations[i + r];
                }
                if (i - r - 1 >= 0) {
                    current_sum -= stations[i - r - 1];
                }
            }
            initial_power[i] = current_sum;
        }

        std::vector<long long> additions(n + 1, 0);
        long long current_added_power = 0;

        for (int i = 0; i < n; ++i) {
            current_added_power += additions[i];

            if (initial_power[i] + current_added_power < min_power) {
                long long diff = min_power - (initial_power[i] + current_added_power);
                k -= diff;
                if (k < 0) {
                    return false;
                }
                current_added_power += diff;
                if (i + 2 * r + 1 < n) {
                    additions[i + 2 * r + 1] -= diff;
                }
            }
        }
        return true;
    }
};