#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    bool can_complete(long long time, const std::vector<int>& trips, int totalTrips) {
        long long completed_trips_count = 0;
        for (int t : trips) {
            completed_trips_count += time / t;
            if (completed_trips_count >= totalTrips) {
                return true;
            }
        }
        return completed_trips_count >= totalTrips;
    }

    long long minimumTime(std::vector<int>& trips, int totalTrips) {
        long long left = 1;
        long long max_trip_time = 0;
        for (int t : trips) {
            if (t > max_trip_time) {
                max_trip_time = t;
            }
        }
        long long right = max_trip_time * totalTrips;

        long long ans = right;

        while (left <= right) {
            long long mid = left + (right - left) / 2;
            if (can_complete(mid, trips, totalTrips)) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return ans;
    }
};