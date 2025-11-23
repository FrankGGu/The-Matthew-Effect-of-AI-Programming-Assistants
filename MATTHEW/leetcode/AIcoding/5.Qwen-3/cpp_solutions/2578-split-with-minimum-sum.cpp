#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumSum(vector<int>& nums) {
        int n = nums.size();
        vector<int> left(n, 0);
        vector<int> right(n, 0);

        left[0] = nums[0];
        for (int i = 1; i < n; ++i) {
            left[i] = left[i - 1] + nums[i];
        }

        right[n - 1] = nums[n - 1];
        for (int i = n - 2; i >= 0; --i) {
            right[i] = right[i + 1] + nums[i];
        }

        int minSum = INT_MAX;
        for (int i = 1; i < n - 1; ++i) {
            int sum = left[i] + right[i + 1];
            if (sum < minSum) {
                minSum = sum;
            }
        }

        return minSum;
    }
};