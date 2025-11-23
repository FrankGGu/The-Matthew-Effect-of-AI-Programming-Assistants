#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumScore(vector<vector<int>>& intervals, int k) {
        sort(intervals.begin(), intervals.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        int score = 0;
        int currentEnd = -1;

        for (const auto& interval : intervals) {
            if (interval[0] > currentEnd) {
                score += interval[1] - interval[0] + 1;
                currentEnd = interval[1];
            }
        }

        return score;
    }
};