#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minDays(vector<int>& bloomDay, int m, int k) {
        int n = bloomDay.size();
        if ((long long)m * k > n) {
            return -1;
        }

        int left = 1, right = *max_element(bloomDay.begin(), bloomDay.end());
        int ans = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            int bouquets = 0;
            int flowers = 0;
            for (int i = 0; i < n; ++i) {
                if (bloomDay[i] <= mid) {
                    flowers++;
                    if (flowers == k) {
                        bouquets++;
                        flowers = 0;
                    }
                } else {
                    flowers = 0;
                }
            }

            if (bouquets >= m) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return ans;
    }
};