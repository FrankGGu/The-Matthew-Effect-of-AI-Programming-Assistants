#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int numberOfWays(vector<int>& nums) {
        int n = nums.size();
        long long total = 0;
        for (int num : nums) {
            total += num;
        }
        long long leftSum = 0;
        int count = 0;
        for (int i = 0; i < n - 1; ++i) {
            leftSum += nums[i];
            long long rightSum = total - leftSum;
            if (leftSum > rightSum) {
                ++count;
            }
        }
        return count;
    }
};