#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    long long sumSubarrayRanges(vector<int>& nums) {
        int n = nums.size();
        long long result = 0;

        for (int i = 0; i < n; i++) {
            int minVal = nums[i];
            int maxVal = nums[i];
            for (int j = i + 1; j < n; j++) {
                minVal = min(minVal, nums[j]);
                maxVal = max(maxVal, nums[j]);
                result += maxVal - minVal;
            }
        }

        return result;
    }
};