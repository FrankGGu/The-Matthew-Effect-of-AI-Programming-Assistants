#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int findBestValue(vector<int>& arr, int target) {
        sort(arr.begin(), arr.end());
        int n = arr.size();
        int left = 0, right = arr[n - 1];
        int bestValue = 0;
        int minDiff = INT_MAX;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            int sum = 0;
            for (int num : arr) {
                sum += min(num, mid);
            }

            int diff = abs(sum - target);
            if (diff < minDiff) {
                minDiff = diff;
                bestValue = mid;
            } else if (diff == minDiff && mid < bestValue) {
                bestValue = mid;
            }

            if (sum > target) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return bestValue;
    }
};