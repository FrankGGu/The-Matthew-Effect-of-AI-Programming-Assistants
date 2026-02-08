#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int waysToMakeFair(vector<int>& nums) {
        int n = nums.size();
        int total = 0;
        for (int i = 0; i < n; ++i) {
            total += nums[i];
        }

        int left_sum = 0;
        int right_sum = 0;
        int count = 0;

        for (int i = 0; i < n; ++i) {
            if (i > 0) {
                left_sum += nums[i - 1];
            }
            if (i < n - 1) {
                right_sum += nums[i + 1];
            }

            int left_even = 0;
            int left_odd = 0;
            int right_even = 0;
            int right_odd = 0;

            for (int j = 0; j < i; ++j) {
                if (j % 2 == 0) {
                    left_even += nums[j];
                } else {
                    left_odd += nums[j];
                }
            }

            for (int j = i + 1; j < n; ++j) {
                if (j % 2 == 0) {
                    right_even += nums[j];
                } else {
                    right_odd += nums[j];
                }
            }

            if (left_even + right_odd == left_odd + right_even) {
                ++count;
            }
        }

        return count;
    }
};