#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimizeMax(vector<int>& nums, int maxAmount) {
        sort(nums.begin(), nums.end());
        int left = 0, right = nums.back() - nums[0];
        int result = right;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            int count = 1;
            int prev = nums[0];

            for (int i = 1; i < nums.size(); ++i) {
                if (nums[i] - prev > mid) {
                    count++;
                    prev = nums[i];
                }
            }

            if (count <= maxAmount) {
                result = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return result;
    }
};