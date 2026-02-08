class Solution {
public:
    long long minimumTime(vector<int>& time, int totalTrips) {
        long long left = 1, right = 1e14, result = right;

        while (left <= right) {
            long long mid = left + (right - left) / 2;
            long long trips = 0;

            for (int t : time) {
                trips += mid / t;
                if (trips >= totalTrips) break;
            }

            if (trips >= totalTrips) {
                result = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return result;
    }
};