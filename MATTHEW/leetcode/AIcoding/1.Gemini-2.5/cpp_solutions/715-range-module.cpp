#include <map>
#include <vector>
#include <algorithm>
#include <iterator>

class RangeModule {
private:
    std::map<int, int> ranges;

public:
    RangeModule() {
    }

    void addRange(int left, int right) {
        if (left >= right) return;

        auto it = ranges.upper_bound(left);
        auto start_it = it;
        if (start_it != ranges.begin()) {
            auto prev = std::prev(start_it);
            if (prev->second >= left) {
                start_it = prev;
            }
        }

        while (it != ranges.end() && it->first <= right) {
            left = std::min(left, it->first);
            right = std::max(right, it->second);
            it++;
        }

        ranges.erase(start_it, it);
        ranges[left] = right;
    }

    bool queryRange(int left, int right) {
        if (left >= right) return true;
        auto it = ranges.upper_bound(left);
        if (it == ranges.begin()) {
            return false;
        }
        it = std::prev(it);
        return it->second >= right;
    }

    void removeRange(int left, int right) {
        if (left >= right) return;

        auto it = ranges.upper_bound(left);
        auto start_it = it;
        if (start_it != ranges.begin()) {
            auto prev = std::prev(start_it);
            if (prev->second > left) {
                start_it = prev;
            }
        }

        std::vector<std::pair<int, int>> to_add;

        auto end_it = start_it;
        while (end_it != ranges.end() && end_it->first < right) {
            if (end_it->first < left) {
                to_add.push_back({end_it->first, left});
            }
            if (end_it->second > right) {
                to_add.push_back({right, end_it->second});
            }
            end_it++;
        }

        ranges.erase(start_it, end_it);

        for (const auto& p : to_add) {
            ranges[p.first] = p.second;
        }
    }
};