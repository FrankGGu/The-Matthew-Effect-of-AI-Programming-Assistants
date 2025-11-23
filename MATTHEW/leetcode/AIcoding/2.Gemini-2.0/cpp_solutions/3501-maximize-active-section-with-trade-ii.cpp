#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximizeActiveSections(vector<int>& start, vector<int>& end) {
        int n = start.size();
        vector<pair<int, int>> intervals;
        for (int i = 0; i < n; ++i) {
            intervals.push_back({start[i], end[i]});
        }

        sort(intervals.begin(), intervals.end());

        vector<int> ends;
        for (auto& interval : intervals) {
            auto it = upper_bound(ends.begin(), ends.end(), interval.first);
            if (it == ends.begin()) {
                ends.insert(ends.begin(), interval.second);
            } else {
                it--;
                *it = interval.second;
                sort(ends.begin(), ends.end());
            }
        }

        return ends.size();
    }
};