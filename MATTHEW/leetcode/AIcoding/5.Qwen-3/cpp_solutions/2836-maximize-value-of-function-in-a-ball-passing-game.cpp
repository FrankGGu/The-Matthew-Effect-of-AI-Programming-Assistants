#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxValueOfFunction(int n, vector<int>& nums) {
        vector<int> left(n);
        vector<int> right(n);

        left[0] = nums[0];
        for (int i = 1; i < n; ++i) {
            left[i] = max(left[i - 1], nums[i]);
        }

        right[n - 1] = nums[n - 1];
        for (int i = n - 2; i >= 0; --i) {
            right[i] = max(right[i + 1], nums[i]);
        }

        long long result = 0;
        for (int i = 0; i < n; ++i) {
            result = max(result, static_cast<long long>(left[i]) + right[i]);
        }

        return result;
    }
};