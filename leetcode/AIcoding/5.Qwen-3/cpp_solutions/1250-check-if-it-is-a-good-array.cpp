#include <iostream>
#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    bool isGoodArray(vector<int>& nums) {
        int gcd = nums[0];
        for (int i = 1; i < nums.size(); ++i) {
            gcd = gcd(gcd, nums[i]);
            if (gcd == 1) break;
        }
        return gcd == 1;
    }
};