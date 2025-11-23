class RangeModule {
public:
    set<pair<int, int>> ranges;

    RangeModule() {}

    void addRange(int left, int right) {
        auto it = ranges.lower_bound({left, left});
        if (it != ranges.begin()) {
            --it;
            if (it->second >= left) {
                left = min(left, it->first);
                right = max(right, it->second);
                it = ranges.erase(it);
            } else {
                ++it;
            }
        }
        while (it != ranges.end() && it->first <= right) {
            right = max(right, it->second);
            it = ranges.erase(it);
        }
        ranges.insert({left, right});
    }

    bool queryRange(int left, int right) {
        auto it = ranges.lower_bound({left, left});
        if (it != ranges.begin()) {
            --it;
            if (it->second >= right) {
                return true;
            }
        }
        return false;
    }

    void removeRange(int left, int right) {
        auto it = ranges.lower_bound({left, left});
        if (it != ranges.begin()) {
            --it;
            if (it->second > left) {
                if (it->second > right) {
                    ranges.insert({right, it->second});
                }
                it->second = left;
                ++it;
            } else {
                ++it;
            }
        }
        while (it != ranges.end() && it->first < right) {
            if (it->second > right) {
                ranges.insert({right, it->second});
            }
            it = ranges.erase(it);
        }
    }
};