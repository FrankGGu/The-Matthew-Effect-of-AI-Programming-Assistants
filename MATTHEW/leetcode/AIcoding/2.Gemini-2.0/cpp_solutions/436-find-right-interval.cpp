#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    vector<int> findRightInterval(vector<vector<int>>& intervals) {
        int n = intervals.size();
        vector<int> result(n, -1);
        map<int, int> start_index;

        for (int i = 0; i < n; ++i) {
            start_index[intervals[i][0]] = i;
        }

        for (int i = 0; i < n; ++i) {
            int target = intervals[i][1];
            auto it = start_index.lower_bound(target);
            if (it != start_index.end()) {
                result[i] = it->second;
            }
        }

        return result;
    }
};