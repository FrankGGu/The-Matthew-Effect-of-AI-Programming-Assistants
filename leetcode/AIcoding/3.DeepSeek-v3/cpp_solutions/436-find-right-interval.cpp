class Solution {
public:
    vector<int> findRightInterval(vector<vector<int>>& intervals) {
        map<int, int> startToIndex;
        for (int i = 0; i < intervals.size(); ++i) {
            startToIndex[intervals[i][0]] = i;
        }

        vector<int> res;
        for (const auto& interval : intervals) {
            auto it = startToIndex.lower_bound(interval[1]);
            if (it != startToIndex.end()) {
                res.push_back(it->second);
            } else {
                res.push_back(-1);
            }
        }
        return res;
    }
};