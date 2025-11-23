#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumSum(vector<int>& arr) {
        int n = arr.size();
        if (n == 1) return arr[0];

        vector<int> left(n), right(n);
        left[0] = arr[0];
        for (int i = 1; i < n; ++i) {
            left[i] = max(arr[i], left[i-1] + arr[i]);
        }

        right[n-1] = arr[n-1];
        for (int i = n-2; i >= 0; --i) {
            right[i] = max(arr[i], right[i+1] + arr[i]);
        }

        int res = max(left[n-1], right[0]);
        for (int i = 1; i < n-1; ++i) {
            res = max(res, left[i-1] + right[i+1]);
        }

        return res;
    }
};