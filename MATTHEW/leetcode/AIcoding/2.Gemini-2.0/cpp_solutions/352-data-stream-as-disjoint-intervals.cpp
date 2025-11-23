#include <set>
#include <vector>

using namespace std;

class SummaryRanges {
public:
    SummaryRanges() {

    }

    void addNum(int value) {
        intervals.insert(value);
    }

    vector<vector<int>> getIntervals() {
        if (intervals.empty()) return {};

        vector<vector<int>> result;
        int start = -1, end = -1;

        for (int val : intervals) {
            if (start == -1) {
                start = val;
                end = val;
            } else if (val == end + 1) {
                end = val;
            } else {
                result.push_back({start, end});
                start = val;
                end = val;
            }
        }

        result.push_back({start, end});
        return result;
    }

private:
    set<int> intervals;
};