#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    bool isSplitable(vector<int>& nums, int m) {
        int count = 1;
        int currentSum = 0;
        for (int num : nums) {
            currentSum += num;
            if (currentSum > m) {
                count++;
                currentSum = num;
                if (count > 2) {
                    return false;
                }
            }
        }
        return true;
    }

    int splitArray(vector<int>& nums) {
        int left = *max_element(nums.begin(), nums.end());
        int right = accumulate(nums.begin(), nums.end(), 0);
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (isSplitable(nums, mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }
};