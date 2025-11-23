class RangeModule {
private:
    map<int, int> intervals;

public:
    RangeModule() {

    }

    void addRange(int left, int right) {
        auto l = intervals.upper_bound(left);
        auto r = intervals.upper_bound(right);

        if (l != intervals.begin()) {
            l--;
            if (l->second < left) {
                l++;
            }
        }

        if (l != r) {
            left = min(left, l->first);
            right = max(right, (--r)->second);
            intervals.erase(l, ++r);
        }

        intervals[left] = right;
    }

    bool queryRange(int left, int right) {
        auto it = intervals.upper_bound(left);
        if (it == intervals.begin()) return false;
        it--;
        return it->second >= right;
    }

    void removeRange(int left, int right) {
        auto l = intervals.upper_bound(left);
        auto r = intervals.upper_bound(right);

        if (l != intervals.begin()) {
            l--;
            if (l->second < left) {
                l++;
            }
        }

        if (l == r) return;

        int new_left = min(left, l->first);
        int new_right = max(right, (--r)->second);

        intervals.erase(l, ++r);

        if (new_left < left) {
            intervals[new_left] = left;
        }
        if (right < new_right) {
            intervals[right] = new_right;
        }
    }
};