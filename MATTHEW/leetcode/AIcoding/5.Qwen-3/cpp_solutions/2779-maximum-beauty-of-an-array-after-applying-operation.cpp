#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumBeauty(vector<int>& nums, int k) {
        vector<pair<int, int>> intervals;
        for (int num : nums) {
            intervals.emplace_back(num - k, num + k);
        }
        sort(intervals.begin(), intervals.end());
        int maxBeauty = 0;
        int left = 0;
        for (int right = 0; right < intervals.size(); ++right) {
            while (intervals[left].second < intervals[right].first) {
                ++left;
            }
            maxBeauty = max(maxBeauty, right - left + 1);
        }
        return maxBeauty;
    }
};