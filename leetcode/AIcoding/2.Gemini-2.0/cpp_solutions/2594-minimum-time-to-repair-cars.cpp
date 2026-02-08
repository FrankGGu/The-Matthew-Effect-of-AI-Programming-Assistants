#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long repairCars(vector<int>& ranks, int cars) {
        long long low = 0, high = 1e14;
        long long ans = high;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            long long completedCars = 0;
            for (int rank : ranks) {
                completedCars += (long long)sqrt((double)mid / rank);
            }

            if (completedCars >= cars) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return ans;
    }
};