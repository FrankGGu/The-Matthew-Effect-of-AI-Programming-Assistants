#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int threeSumClosest(vector<int>& nums, int target) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int closest = nums[0] + nums[1] + nums[2];
        for (int i = 0; i < n - 2; ++i) {
            int left = i + 1;
            int right = n - 1;
            while (left < right) {
                int current = nums[i] + nums[left] + nums[right];
                if (abs(current - target) < abs(closest - target)) {
                    closest = current;
                }
                if (current == target) {
                    return closest;
                } else if (current < target) {
                    ++left;
                } else {
                    --right;
                }
            }
        }
        return closest;
    }
};