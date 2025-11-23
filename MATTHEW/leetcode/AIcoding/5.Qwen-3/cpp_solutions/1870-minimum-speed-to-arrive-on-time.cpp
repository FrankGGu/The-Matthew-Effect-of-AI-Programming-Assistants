#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int minSpeedOnTime(int n, vector<int>& time) {
        if (n == 0) return -1;
        int left = 1;
        int right = 1e6;
        int result = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            double total = 0.0;
            for (int i = 0; i < n - 1; ++i) {
                total += ceil(static_cast<double>(time[i]) / mid);
            }
            total += static_cast<double>(time[n - 1]) / mid;

            if (total < 1.0) {
                result = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return result;
    }
};