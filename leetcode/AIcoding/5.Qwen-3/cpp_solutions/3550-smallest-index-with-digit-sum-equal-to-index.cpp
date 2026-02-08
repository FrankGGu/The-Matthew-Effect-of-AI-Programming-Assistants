#include <iostream>
#include <vector>
#include <cmath>

class Solution {
public:
    int smallestEqual(int n, std::vector<int>& nums) {
        for (int i = 0; i < n; ++i) {
            int sum = 0;
            int num = nums[i];
            while (num > 0) {
                sum += num % 10;
                num /= 10;
            }
            if (sum == i) {
                return i;
            }
        }
        return -1;
    }
};