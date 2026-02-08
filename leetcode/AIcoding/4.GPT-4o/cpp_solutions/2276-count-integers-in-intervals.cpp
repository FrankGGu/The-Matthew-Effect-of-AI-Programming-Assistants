class CountIntervals {
public:
    set<pair<int, int>> intervals;

    CountIntervals() {}

    void add(int left, int right) {
        auto it = intervals.lower_bound({left, left});
        if (it != intervals.begin()) {
            --it;
            if (it->second >= left - 1) {
                left = min(left, it->first);
                right = max(right, it->second);
                it = intervals.erase(it);
            } else {
                ++it;
            }
        }
        while (it != intervals.end() && it->first <= right + 1) {
            right = max(right, it->second);
            it = intervals.erase(it);
        }
        intervals.insert({left, right});
    }

    int count() {
        int total = 0;
        for (const auto& interval : intervals) {
            total += interval.second - interval.first + 1;
        }
        return total;
    }
};