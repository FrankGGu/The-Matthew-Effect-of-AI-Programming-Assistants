#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums) {
        int n = nums.size();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (nums[i] != 1) {
                int gcd_val = nums[i];
                for (int j = i + 1; j < n; ++j) {
                    gcd_val = __gcd(gcd_val, nums[j]);
                    if (gcd_val == 1) {
                        break;
                    }
                }
                if (gcd_val != 1) {
                    return -1;
                }
                for (int j = i + 1; j < n; ++j) {
                    nums[j] = __gcd(nums[j], nums[i]);
                    count++;
                }
            }
        }
        return count;
    }
};