#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximizeTheMinimumGameScore(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int left = 0, right = n - 1;
        int result = INT_MAX;
        while (left < right) {
            result = min(result, nums[left] + nums[right]);
            left++;
            right--;
        }
        return result;
    }
};