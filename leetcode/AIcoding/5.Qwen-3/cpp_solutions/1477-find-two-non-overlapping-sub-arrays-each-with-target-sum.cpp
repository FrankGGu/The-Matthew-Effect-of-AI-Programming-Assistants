#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int minSumOfTwoSubarrays(vector<int>& arr, int target) {
        int n = arr.size();
        vector<int> dp(n, INT_MAX);
        vector<int> left(n, INT_MAX);
        vector<int> right(n, INT_MAX);

        int sum = 0;
        for (int i = 0; i < n; ++i) {
            sum += arr[i];
            if (sum == target) {
                left[i] = arr[i];
            } else if (sum > target) {
                sum = 0;
            }
        }

        sum = 0;
        for (int i = n - 1; i >= 0; --i) {
            sum += arr[i];
            if (sum == target) {
                right[i] = arr[i];
            } else if (sum > target) {
                sum = 0;
            }
        }

        for (int i = 1; i < n; ++i) {
            left[i] = min(left[i], left[i - 1]);
        }

        for (int i = n - 2; i >= 0; --i) {
            right[i] = min(right[i], right[i + 1]);
        }

        int result = INT_MAX;
        for (int i = 0; i < n - 1; ++i) {
            if (left[i] != INT_MAX && right[i + 1] != INT_MAX) {
                result = min(result, left[i] + right[i + 1]);
            }
        }

        return result;
    }
};