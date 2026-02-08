#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minTime(vector<int>& time, int m) {
        long long low = 0;
        long long high = 0;
        for (int t : time) {
            high += t;
        }

        long long ans = high;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            if (check(time, m, mid)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return static_cast<int>(ans);
    }

private:
    bool check(const vector<int>& time, int m, long long max_time_limit) {
        int days_needed = 1;
        long long current_day_sum = 0;
        int current_day_max = 0;

        for (int t : time) {
            current_day_sum += t;
            current_day_max = max(current_day_max, t);

            if (current_day_sum - current_day_max > max_time_limit) {
                days_needed++;
                current_day_sum = t;
                current_day_max = t;
            }
        }

        return days_needed <= m;
    }
};