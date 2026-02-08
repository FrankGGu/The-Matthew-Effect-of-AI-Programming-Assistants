#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxCoins(int a, int b, int c) {
        vector<int> nums = {a, b, c};
        sort(nums.begin(), nums.end());
        return nums[1];
    }
};