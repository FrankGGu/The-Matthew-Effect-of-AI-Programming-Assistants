#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int splitArray(vector<int>& nums, int m) {
        int left = *max_element(nums.begin(), nums.end());
        int right = accumulate(nums.begin(), nums.end(), 0);

        while (left < right) {
            int mid = left + (right - left) / 2;
            int count = 1;
            int current_sum = 0;

            for (int num : nums) {
                if (current_sum + num > mid) {
                    count++;
                    current_sum = num;
                } else {
                    current_sum += num;
                }
            }

            if (count <= m) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        return left;
    }
};