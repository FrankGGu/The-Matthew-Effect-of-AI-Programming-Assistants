#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    long long maximumScore(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> left(n, 0), right(n, 0);

        for (int i = 0; i < n; ++i) {
            if (i == 0 || nums[i] <= nums[i - 1]) {
                left[i] = i;
            } else {
                left[i] = left[i - 1];
            }
        }

        for (int i = n - 1; i >= 0; --i) {
            if (i == n - 1 || nums[i] <= nums[i + 1]) {
                right[i] = i;
            } else {
                right[i] = right[i + 1];
            }
        }

        long long maxScore = 0;
        for (int i = 0; i < n; ++i) {
            int l = left[i];
            int r = right[i];
            int len = r - l + 1;
            maxScore = max(maxScore, (long long)nums[i] * len);
        }

        return maxScore;
    }
};