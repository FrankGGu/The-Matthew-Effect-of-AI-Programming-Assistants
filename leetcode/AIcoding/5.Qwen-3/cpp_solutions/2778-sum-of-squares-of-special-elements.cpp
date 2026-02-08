#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int sumOfSquares(vector<int>& nums) {
        int result = 0;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            if (i % 2 == 0) {
                result += nums[i] * nums[i];
            }
        }
        return result;
    }
};