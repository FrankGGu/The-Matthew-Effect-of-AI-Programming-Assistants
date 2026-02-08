#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxSumKElements(vector<int>& nums, int k) {
        sort(nums.begin(), nums.end(), greater<int>());
        long long sum = 0;
        for (int i = 0; i < k; ++i) {
            sum += nums[i];
        }
        return sum;
    }
};