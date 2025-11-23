#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long countSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        long long result = 0;
        int maxEle = *max_element(nums.begin(), nums.end());
        int count = 0;
        int left = 0;

        for (int right = 0; right < n; ++right) {
            if (nums[right] == maxEle) {
                count++;
            }

            while (count >= k) {
                result += n - right;
                if (nums[left] == maxEle) {
                    count--;
                }
                left++;
            }
        }

        return result;
    }
};