class Solution {
public:
    int intersectionSizeTwo(vector<vector<int>>& intervals) {
        sort(intervals.begin(), intervals.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1] || (a[1] == b[1] && a[0] > b[0]);
        });
        vector<int> res;
        res.push_back(intervals[0][1] - 1);
        res.push_back(intervals[0][1]);
        for (int i = 1; i < intervals.size(); ++i) {
            int start = intervals[i][0], end = intervals[i][1];
            if (start > res.back()) {
                res.push_back(end - 1);
                res.push_back(end);
            } else if (start == res.back()) {
                res.push_back(end);
            } else if (start > res[res.size() - 2]) {
                res.push_back(end);
            }
        }
        return res.size();
    }
};