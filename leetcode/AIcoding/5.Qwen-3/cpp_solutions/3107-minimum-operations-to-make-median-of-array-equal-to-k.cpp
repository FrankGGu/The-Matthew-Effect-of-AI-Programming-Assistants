#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(int k, vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int mid = n / 2;
        int target = k;
        int operations = 0;
        if (nums[mid] == target) {
            return 0;
        } else if (nums[mid] > target) {
            for (int i = mid; i >= 0; --i) {
                if (nums[i] > target) {
                    operations += nums[i] - target;
                } else {
                    break;
                }
            }
        } else {
            for (int i = mid; i < n; ++i) {
                if (nums[i] < target) {
                    operations += target - nums[i];
                } else {
                    break;
                }
            }
        }
        return operations;
    }
};