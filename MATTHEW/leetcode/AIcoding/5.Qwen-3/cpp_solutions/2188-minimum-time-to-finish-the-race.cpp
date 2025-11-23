#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int minSpeedOnTime(vector<int>& distance, int speed) {
        int n = distance.size();
        if (n == 0) return -1;
        if (n == 1) {
            return (distance[0] + speed - 1) / speed;
        }

        int left = 1;
        int right = 1e6;
        int result = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            double time = 0.0;
            for (int i = 0; i < n - 1; ++i) {
                time += ceil(static_cast<double>(distance[i]) / mid);
            }
            time += static_cast<double>(distance[n - 1]) / mid;

            if (time < 1e-9) {
                result = mid;
                right = mid - 1;
            } else if (time < 1.0) {
                result = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return result;
    }
};