#include <vector>
#include <algorithm>
#include <numeric>

using namespace std;

class Solution {
public:
    long long minimumTravelTime(vector<int>& time, vector<int>& totalTrips, long long maxTime) {
        long long low = 1, high = maxTime + 1;

        while (low < high) {
            long long mid = low + (high - low) / 2;
            long long trips = 0;

            for (int i = 0; i < time.size(); ++i) {
                trips += mid / time[i];
                if (trips >= totalTrips[i]) break;
            }

            if (trips >= accumulate(totalTrips.begin(), totalTrips.end(), 0LL)) {
                high = mid;
            } else {
                low = mid + 1;
            }
        }

        return low;
    }
};