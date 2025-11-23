#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minMoves(vector<int>& nums, int limit) {
        int n = nums.size();
        vector<int> diff(n + 2, 0);

        for (int i = 0; i < n / 2; ++i) {
            int a = nums[i];
            int b = nums[n - 1 - i];
            int minVal = min(a, b);
            int maxVal = max(a, b);
            int sum = a + b;

            diff[1] += 2;
            diff[minVal + 1] -= 1;
            diff[maxVal + 1] -= 1;
            diff[sum] += 1;
            diff[sum + 1] += 1;
        }

        int res = 0;
        int current = 0;
        for (int i = 1; i <= n; ++i) {
            current += diff[i];
            res = max(res, current);
        }

        return res;
    }
};