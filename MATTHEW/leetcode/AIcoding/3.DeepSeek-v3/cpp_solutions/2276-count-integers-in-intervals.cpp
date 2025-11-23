class CountIntervals {
public:
    set<pair<int, int>> intervals;
    int cnt = 0;

    CountIntervals() {

    }

    void add(int left, int right) {
        auto it = intervals.lower_bound({left, -1});
        if (it != intervals.begin()) {
            auto prev_it = prev(it);
            if (prev_it->second >= left) {
                left = prev_it->first;
                right = max(right, prev_it->second);
                cnt -= prev_it->second - prev_it->first + 1;
                intervals.erase(prev_it);
            }
        }
        while (it != intervals.end() && it->first <= right) {
            right = max(right, it->second);
            cnt -= it->second - it->first + 1;
            it = intervals.erase(it);
        }
        intervals.insert({left, right});
        cnt += right - left + 1;
    }

    int count() {
        return cnt;
    }
};