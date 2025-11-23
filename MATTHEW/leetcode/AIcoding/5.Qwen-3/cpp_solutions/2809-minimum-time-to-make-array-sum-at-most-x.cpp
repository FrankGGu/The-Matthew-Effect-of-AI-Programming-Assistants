#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>
#include <cmath>

using namespace std;

class Solution {
public:
    int minTimeToMakeSumAtMostX(vector<int>& nums, int x) {
        int n = nums.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        int left = 0, right = *max_element(nums.begin(), nums.end());
        while (left < right) {
            int mid = left + (right - left) / 2;
            long long total = 0;
            for (int i = 0; i < n; ++i) {
                if (nums[i] > mid) {
                    total += nums[i] - mid;
                }
            }
            if (total <= x) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }
};