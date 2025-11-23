#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    long long sumOfSubsequencePower(vector<int>& nums, int x) {
        long long result = 0;
        int n = nums.size();
        for (int mask = 1; mask < (1 << n); ++mask) {
            long long power = 1;
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) {
                    power *= nums[i];
                }
            }
            result += pow(power, x);
        }
        return result;
    }
};