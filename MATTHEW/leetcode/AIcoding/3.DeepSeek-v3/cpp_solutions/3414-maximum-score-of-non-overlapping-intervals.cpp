class Solution {
public:
    int maximumScore(vector<vector<int>>& intervals) {
        sort(intervals.begin(), intervals.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        int end = INT_MIN;
        int score = 0;

        for (const auto& interval : intervals) {
            if (interval[0] >= end) {
                score += interval[2];
                end = interval[1];
            }
        }

        return score;
    }
};