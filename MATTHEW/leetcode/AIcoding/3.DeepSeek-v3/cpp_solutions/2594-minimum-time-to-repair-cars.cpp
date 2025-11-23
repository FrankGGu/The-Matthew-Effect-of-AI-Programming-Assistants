#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    long long repairCars(vector<int>& ranks, int cars) {
        long long left = 1;
        long long right = 1LL * *min_element(ranks.begin(), ranks.end()) * cars * cars;
        while (left < right) {
            long long mid = left + (right - left) / 2;
            long long total = 0;
            for (int r : ranks) {
                total += sqrt(mid / r);
            }
            if (total < cars) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
};