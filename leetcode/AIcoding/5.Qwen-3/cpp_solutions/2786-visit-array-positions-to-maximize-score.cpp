#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxScore(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> left(n, 0);
        vector<int> right(n, 0);

        left[0] = nums[0];
        for (int i = 1; i < n; ++i) {
            left[i] = left[i - 1] + nums[i];
        }

        right[n - 1] = nums[n - 1];
        for (int i = n - 2; i >= 0; --i) {
            right[i] = right[i + 1] + nums[i];
        }

        int maxScore = 0;
        for (int i = 0; i < n; ++i) {
            int score = 0;
            if (i - k >= 0) {
                score += left[i - k];
            }
            if (i + k < n) {
                score += right[i + k];
            }
            maxScore = max(maxScore, score);
        }

        return maxScore;
    }
};