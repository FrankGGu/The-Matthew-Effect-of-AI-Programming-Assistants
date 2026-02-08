#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    Solution() {
        intervals = {};
    }

    void add(int value) {
        auto it = intervals.lower_bound(value);
        if (it != intervals.begin()) {
            --it;
            if (it->second >= value - 1) {
                intervals.erase(it);
            }
        }
        while (it != intervals.end() && it->first <= value + 1) {
            if (it->first <= value + 1) {
                value = max(value, it->second);
                intervals.erase(it++);
            } else {
                break;
            }
        }
        intervals[value] = value;
    }

    int size() {
        int count = 0;
        for (const auto& [start, end] : intervals) {
            count += end - start + 1;
        }
        return count;
    }

private:
    map<int, int> intervals;
};