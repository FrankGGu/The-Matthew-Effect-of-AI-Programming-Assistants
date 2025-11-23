#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    long long sumOfPower(vector<int>& nums) {
        long long result = 0;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            long long power = nums[i];
            for (int j = i + 1; j < n; ++j) {
                power *= nums[j];
            }
            result += power;
        }
        return result;
    }
};