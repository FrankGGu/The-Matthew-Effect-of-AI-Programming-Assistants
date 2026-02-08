#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int numSubarrayBounded(int left, int right, int val) {
        if (val < left) return 0;
        if (val > right) return 0;
        return val - left + 1;
    }

    int numSubarraysWithBoundedMaximum(vector<int>& nums, int left, int right) {
        int n = nums.size();
        int res = 0;
        int prev = 0;
        for (int i = 0; i < n; ++i) {
            if (nums[i] < left) {
                res += prev;
            } else if (nums[i] > right) {
                prev = 0;
            } else {
                prev = prev + 1;
                res += prev;
            }
        }
        return res;
    }
};