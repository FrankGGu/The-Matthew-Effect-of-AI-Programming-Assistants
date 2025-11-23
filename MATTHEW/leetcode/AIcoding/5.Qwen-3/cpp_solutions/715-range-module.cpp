#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> ranges;

    Solution() {}

    void addRange(vector<int> range) {
        vector<vector<int>> new_ranges;
        int start = range[0], end = range[1];
        for (auto r : ranges) {
            if (r[1] < start) {
                new_ranges.push_back(r);
            } else if (r[0] > end) {
                new_ranges.push_back(r);
            } else {
                start = min(start, r[0]);
                end = max(end, r[1]);
            }
        }
        new_ranges.push_back({start, end});
        ranges = new_ranges;
    }

    bool queryRange(int left, int right) {
        for (auto r : ranges) {
            if (r[0] <= left && r[1] >= right) {
                return true;
            }
        }
        return false;
    }

    void removeRange(vector<int> range) {
        vector<vector<int>> new_ranges;
        int start = range[0], end = range[1];
        for (auto r : ranges) {
            if (r[1] < start || r[0] > end) {
                new_ranges.push_back(r);
            } else {
                if (r[0] < start) {
                    new_ranges.push_back({r[0], start - 1});
                }
                if (r[1] > end) {
                    new_ranges.push_back({end + 1, r[1]});
                }
            }
        }
        ranges = new_ranges;
    }
};