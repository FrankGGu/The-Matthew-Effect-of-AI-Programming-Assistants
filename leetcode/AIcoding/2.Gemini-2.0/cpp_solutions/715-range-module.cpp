#include <set>

class RangeModule {
public:
    RangeModule() {}

    void addRange(int left, int right) {
        auto it = intervals.lower_bound({left, right});
        while (it != intervals.begin()) {
            auto prev = std::prev(it);
            if (prev->second < left) break;
            left = std::min(left, prev->first);
            right = std::max(right, prev->second);
            it = intervals.erase(prev);
        }
        while (it != intervals.end() && it->first <= right) {
            right = std::max(right, it->second);
            it = intervals.erase(it);
        }
        intervals.insert({left, right});
    }

    bool queryRange(int left, int right) {
        auto it = intervals.upper_bound({left, right});
        if (it == intervals.begin()) return false;
        it = std::prev(it);
        return it->first <= left && it->second >= right;
    }

    void removeRange(int left, int right) {
        auto it = intervals.lower_bound({left, right});
        if (it != intervals.begin()) {
            auto prev = std::prev(it);
            if (prev->second > left) {
                int l = prev->first;
                int r = prev->second;
                intervals.erase(prev);
                intervals.insert({l, left});
                if (r > right) intervals.insert({right, r});
                else if (r > left) intervals.insert({left, r});
            }
        }
        while (it != intervals.end() && it->first < right) {
            int l = it->first;
            int r = it->second;
            it = intervals.erase(it);
            if (l < left) intervals.insert({l, left});
            if (r > right) intervals.insert({right, r});
        }
    }

private:
    std::set<std::pair<int, int>> intervals;
};