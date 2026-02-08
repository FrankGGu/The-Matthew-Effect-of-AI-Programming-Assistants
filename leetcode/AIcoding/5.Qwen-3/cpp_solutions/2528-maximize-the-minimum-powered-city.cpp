#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximizeTheMinimumPoweredCity(vector<int>& cities, int k) {
        int n = cities.size();
        vector<int> power(n, 0);

        for (int i = 0; i < n; ++i) {
            power[i] = cities[i];
        }

        sort(power.begin(), power.end());

        int left = 0;
        int right = power[n - 1];
        int result = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            int count = 1;
            int prev = power[0];

            for (int i = 1; i < n; ++i) {
                if (power[i] - prev >= mid) {
                    count++;
                    prev = power[i];
                }
            }

            if (count >= k) {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return result;
    }
};