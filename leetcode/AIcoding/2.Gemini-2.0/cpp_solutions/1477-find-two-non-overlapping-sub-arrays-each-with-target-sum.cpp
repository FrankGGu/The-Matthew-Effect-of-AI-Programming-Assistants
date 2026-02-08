#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minSumOfLengths(vector<int>& arr, int target) {
        int n = arr.size();
        vector<int> left(n, INT_MAX);
        vector<int> right(n, INT_MAX);

        int sum = 0;
        int start = 0;
        int minLen = INT_MAX;
        for (int i = 0; i < n; ++i) {
            sum += arr[i];
            while (sum > target) {
                sum -= arr[start];
                start++;
            }
            if (sum == target) {
                minLen = min(minLen, i - start + 1);
            }
            left[i] = minLen;
            if (i > 0) {
                left[i] = min(left[i], left[i - 1]);
            }
        }

        sum = 0;
        int end = n - 1;
        minLen = INT_MAX;
        for (int i = n - 1; i >= 0; --i) {
            sum += arr[i];
            while (sum > target) {
                sum -= arr[end];
                end--;
            }
            if (sum == target) {
                minLen = min(minLen, end - i + 1);
            }
            right[i] = minLen;
            if (i < n - 1) {
                right[i] = min(right[i], right[i + 1]);
            }
        }

        int ans = INT_MAX;
        for (int i = 0; i < n - 1; ++i) {
            if (left[i] != INT_MAX && right[i + 1] != INT_MAX) {
                ans = min(ans, left[i] + right[i + 1]);
            }
        }

        return ans == INT_MAX ? -1 : ans;
    }
};