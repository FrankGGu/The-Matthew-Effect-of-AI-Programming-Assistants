#include <map>
#include <algorithm>

class CountIntervals {
private:
    std::map<int, int> intervals;
    long long totalCount;

public:
    CountIntervals() {
        totalCount = 0;
    }

    void add(int left, int right) {
        auto it = intervals.upper_bound(left);

        int current_left = left;
        int current_right = right;
        long long removed_len = 0;

        if (it != intervals.begin()) {
            auto prev_it = std::prev(it);
            if (prev_it->second >= left - 1) {
                current_left = std::min(current_left, prev_it->first);
                current_right = std::max(current_right, prev_it->second);
                removed_len += (prev_it->second - prev_it->first + 1);
                it = intervals.erase(prev_it);
            }
        }

        while (it != intervals.end() && it->first <= current_right + 1) {
            current_right = std::max(current_right, it->second);
            removed_len += (it->second - it->first + 1);
            it = intervals.erase(it);
        }

        intervals[current_left] = current_right;
        totalCount += ((long long)current_right - current_left + 1) - removed_len;
    }

    int count() {
        return static_cast<int>(totalCount);
    }
};