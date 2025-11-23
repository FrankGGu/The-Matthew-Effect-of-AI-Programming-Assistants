#include <vector>
#include <map>
#include <algorithm>

class SummaryRanges {
private:
    std::map<int, int> intervals;

public:
    SummaryRanges() {

    }

    void addNum(int value) {
        auto it = intervals.upper_bound(value);

        if (it != intervals.begin()) {
            auto prev_it = std::prev(it);
            if (prev_it->first <= value && value <= prev_it->second) {
                return;
            }
        }

        int start = value;
        int end = value;

        auto it_left = intervals.upper_bound(value - 1);
        if (it_left != intervals.begin()) {
            auto prev_it_left = std::prev(it_left);
            if (prev_it_left->second == value - 1) {
                start = prev_it_left->first;
                intervals.erase(prev_it_left);
            }
        }

        auto it_right = intervals.find(value + 1);
        if (it_right != intervals.end()) {
            end = it_right->second;
            intervals.erase(it_right);
        }

        intervals[start] = end;
    }

    std::vector<std::vector<int>> getIntervals() {
        std::vector<std::vector<int>> result;
        for (const auto& pair : intervals) {
            result.push_back({pair.first, pair.second});
        }
        return result;
    }
};