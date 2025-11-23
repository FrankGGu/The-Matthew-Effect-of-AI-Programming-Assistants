#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> findRightInterval(const vector<vector<int>>& intervals) {
        int n = intervals.size();
        vector<int> result(n, 0);
        vector<pair<int, int>> sortedIntervals(n);

        for (int i = 0; i < n; ++i) {
            sortedIntervals[i] = {intervals[i][0], i};
        }

        sort(sortedIntervals.begin(), sortedIntervals.end());

        for (int i = 0; i < n; ++i) {
            int left = 0, right = n - 1;
            int target = intervals[i][1];
            int index = -1;

            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (sortedIntervals[mid].first >= target) {
                    index = sortedIntervals[mid].second;
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }

            result[i] = index;
        }

        return result;
    }
};