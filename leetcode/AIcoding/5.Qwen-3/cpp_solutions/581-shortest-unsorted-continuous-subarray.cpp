#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findUnsortedSubarray(vector<int>& nums) {
        int n = nums.size();
        int start = 0, end = n - 1;

        while (start < n - 1 && nums[start] <= nums[start + 1]) {
            start++;
        }

        if (start == n - 1) {
            return 0;
        }

        while (end > 0 && nums[end] >= nums[end - 1]) {
            end--;
        }

        int minSub = *min_element(nums.begin() + start, nums.begin() + end + 1);
        int maxSub = *max_element(nums.begin() + start, nums.begin() + end + 1);

        while (start > 0 && nums[start - 1] > minSub) {
            start--;
        }

        while (end < n - 1 && nums[end + 1] < maxSub) {
            end++;
        }

        return end - start + 1;
    }
};