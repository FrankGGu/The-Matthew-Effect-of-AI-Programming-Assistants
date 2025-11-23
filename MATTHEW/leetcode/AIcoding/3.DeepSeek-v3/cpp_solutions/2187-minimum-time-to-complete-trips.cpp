class Solution {
public:
    long long minimumTime(vector<int>& time, int totalTrips) {
        long long left = 1;
        long long right = 1e14;
        while (left < right) {
            long long mid = left + (right - left) / 2;
            long long trips = 0;
            for (int t : time) {
                trips += mid / t;
            }
            if (trips < totalTrips) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
};