#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minimumTime(vector<int>& time, int totalTrips) {
        long long left = 1;
        long long right = (long long)(*min_element(time.begin(), time.end())) * totalTrips;
        long long ans = right;

        while (left <= right) {
            long long mid = left + (right - left) / 2;
            long long trips = 0;
            for (int t : time) {
                trips += mid / t;
            }

            if (trips >= totalTrips) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return ans;
    }
};