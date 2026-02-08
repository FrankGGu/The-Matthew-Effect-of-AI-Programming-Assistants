#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumScore(vector<int>& nums, int k) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int minScore = INT_MAX;
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                int maxVal = nums[j];
                int minVal = nums[i];
                int midVal = nums[(i + j) / 2];
                int score = maxVal - minVal;
                if (score < minScore) {
                    minScore = score;
                }
            }
        }
        return minScore;
    }
};