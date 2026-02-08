#include <numeric>

class Solution {
public:
    long long countDaysWithoutMeetings(vector<int>& meetings) {
        long long totalMeetings = accumulate(meetings.begin(), meetings.end(), 0LL);
        long long low = 0, high = 1e14;
        long long ans = high;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            long long availableTime = mid;
            long long requiredTime = 0;

            for (int meeting : meetings) {
                requiredTime += (mid > meeting ? meeting : mid);
            }

            if (availableTime > requiredTime) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return ans;
    }
};