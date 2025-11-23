#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minNumber(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int result = 0;
        for (int i = 0; i < nums.size(); ++i) {
            result = result * 10 + nums[i];
        }
        return result;
    }
};