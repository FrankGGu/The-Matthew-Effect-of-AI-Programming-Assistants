#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    class Interval {
    public:
        int start;
        int end;
        Interval() : start(0), end(0) {}
        Interval(int s, int e) : start(s), end(e) {}
    };

    vector<Interval> result;
    map<int, int> intervals;

    void addNum(int val) {
        if (intervals.empty()) {
            intervals[val] = val;
            return;
        }

        auto it = intervals.lower_bound(val);
        if (it != intervals.begin()) {
            auto prev = it;
            prev--;
            if (prev->second >= val - 1) {
                intervals.erase(prev);
                val = prev->first;
            }
        }

        if (it != intervals.end()) {
            if (it->first <= val + 1) {
                intervals[val] = max(val, it->second);
                intervals.erase(it);
            } else {
                intervals[val] = val;
            }
        } else {
            intervals[val] = val;
        }
    }

    vector<Interval> getIntervals() {
        result.clear();
        for (const auto& pair : intervals) {
            result.push_back(Interval(pair.first, pair.second));
        }
        return result;
    }
};