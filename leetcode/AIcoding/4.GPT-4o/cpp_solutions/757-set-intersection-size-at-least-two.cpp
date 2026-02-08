class Solution {
public:
    int intersectionSizeTwo(vector<vector<int>>& intervals) {
        sort(intervals.begin(), intervals.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        multiset<int> points;
        int count = 0;

        for (const auto& interval : intervals) {
            while (points.size() < 2 || (points.size() && *points.rbegin() < interval[0])) {
                if (points.size() < 2) {
                    points.insert(interval[1]);
                } else {
                    points.insert(interval[1] - 1);
                }
                count++;
            }
            if (points.size() >= 2 && *points.rbegin() >= interval[0]) {
                continue;
            }
        }
        return count;
    }
};