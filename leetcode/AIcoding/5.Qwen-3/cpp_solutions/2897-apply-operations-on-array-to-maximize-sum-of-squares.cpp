#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    long long maxSumAfterOperations(vector<int>& nums) {
        int n = nums.size();
        long long sum = 0;
        for (int i = 0; i < n; ++i) {
            sum += static_cast<long long>(nums[i]) * nums[i];
        }
        return sum;
    }
};