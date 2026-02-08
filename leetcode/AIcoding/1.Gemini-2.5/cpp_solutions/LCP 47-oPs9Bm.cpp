#include <vector>
#include <algorithm>

class Solution {
public:
    long long minTime(std::vector<int>& times, int n) {
        long long low = 1;
        long long max_time_val = 0;
        for (int time_val : times) {
            if (time_val > max_time_val) {
                max_time_val = time_val;
            }
        }
        long long high = (long long)n * max_time_val;

        long long ans = high;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            long long people_processed = 0;
            for (int time_val : times) {
                people_processed += mid / time_val;
                if (people_processed >= n) {
                    break;
                }
            }

            if (people_processed >= n) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return ans;
    }
};