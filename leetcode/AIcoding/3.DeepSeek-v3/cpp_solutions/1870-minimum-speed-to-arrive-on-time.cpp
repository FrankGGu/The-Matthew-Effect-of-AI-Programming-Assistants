#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int minSpeedOnTime(vector<int>& dist, double hour) {
        int n = dist.size();
        if (hour <= n - 1) return -1;

        int left = 1;
        int right = 1e7;
        int result = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            double total = 0.0;

            for (int i = 0; i < n - 1; ++i) {
                total += ceil((double)dist[i] / mid);
            }
            total += (double)dist[n - 1] / mid;

            if (total <= hour) {
                result = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return result;
    }
};