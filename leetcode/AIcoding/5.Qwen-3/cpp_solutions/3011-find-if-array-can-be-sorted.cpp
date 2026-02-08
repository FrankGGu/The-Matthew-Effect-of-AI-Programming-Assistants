#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool canBeSorted(vector<int>& nums) {
        vector<int> sortedNums = nums;
        sort(sortedNums.begin(), sortedNums.end());

        int n = nums.size();
        for (int i = 0; i < n; i++) {
            if (nums[i] != sortedNums[i]) {
                int j = i + 1;
                while (j < n && nums[j] != sortedNums[i]) {
                    j++;
                }
                if (j == n) {
                    return false;
                }
                swap(nums[i], nums[j]);
            }
        }
        return true;
    }
};