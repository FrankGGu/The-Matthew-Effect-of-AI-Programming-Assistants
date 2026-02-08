#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findBestValue(vector<int>& nums, int target) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        int left = 0, right = 10000;
        while (left < right) {
            int mid = (left + right) / 2;
            int sum = 0;
            for (int i = 0; i < n; ++i) {
                sum += min(mid, nums[i]);
                if (sum >= target) break;
            }
            if (sum < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        int best = left;
        int sum = 0;
        for (int i = 0; i < n; ++i) {
            sum += min(best, nums[i]);
            if (sum >= target) break;
        }

        if (sum == target) return best;

        int sum_prev = 0;
        for (int i = 0; i < n; ++i) {
            sum_prev += min(best - 1, nums[i]);
            if (sum_prev >= target) break;
        }

        if (abs(sum - target) < abs(sum_prev - target)) {
            return best;
        } else {
            return best - 1;
        }
    }
};