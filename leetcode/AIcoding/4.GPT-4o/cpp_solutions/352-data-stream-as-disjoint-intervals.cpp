#include <vector>
#include <set>
using namespace std;

class SummaryRanges {
public:
    set<pair<int, int>> intervals;

    SummaryRanges() {}

    void addNum(int value) {
        auto it = intervals.lower_bound({value, value});
        if (it != intervals.begin() && (--it)->second + 1 < value) {
            it++; // Move to next interval
        }
        while (it != intervals.end() && it->first <= value + 1) {
            value = max(value, it->second); // Merge intervals
            it = intervals.erase(it);
        }
        intervals.insert({value, value});
    }

    vector<vector<int>> getIntervals() {
        vector<vector<int>> result;
        for (const auto& interval : intervals) {
            result.push_back({interval.first, interval.second});
        }
        return result;
    }
};