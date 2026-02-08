#include <set>

class CountIntervals {
public:
    CountIntervals() {
        count = 0;
    }

    void add(int left, int right) {
        auto it = intervals.lower_bound({left, right});

        while (it != intervals.end() && it->first <= right) {
            left = min(left, it->first);
            right = max(right, it->second);
            count -= (it->second - it->first + 1);
            it = intervals.erase(it);
        }

        it = intervals.lower_bound({left, right});
        if (it != intervals.begin()) {
            it--;
            if (it->second >= left) {
                left = min(left, it->first);
                right = max(right, it->second);
                count -= (it->second - it->first + 1);
                intervals.erase(it++);
            } else {
                it++;
            }
        }

        count += (right - left + 1);
        intervals.insert({left, right});
    }

    int count_() {
        return count;
    }

private:
    set<pair<int, int>> intervals;
    int count;
};