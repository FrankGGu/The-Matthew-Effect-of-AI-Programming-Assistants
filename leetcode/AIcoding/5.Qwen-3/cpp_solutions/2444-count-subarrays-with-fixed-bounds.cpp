#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int countSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        int res = 0;
        int left = 0;
        int minCount = 0;
        int maxCount = 0;

        for (int right = 0; right < n; ++right) {
            if (nums[right] == k) {
                minCount++;
                maxCount++;
            } else if (nums[right] < k) {
                minCount++;
            } else {
                maxCount++;
            }

            while (minCount > 0 && maxCount > 0) {
                if (nums[left] == k) {
                    minCount--;
                    maxCount--;
                } else if (nums[left] < k) {
                    minCount--;
                } else {
                    maxCount--;
                }
                left++;
            }

            res += left;
        }

        return res;
    }
};