#include <map>
#include <algorithm> // For std::min, std::max

class CountIntervals {
private:
    std::map<int, int> intervals; // Stores [start, end]
    long long total_count;

public:
    CountIntervals() : total_count(0) {

    }

    void add(int left, int right) {
        // Find the first interval whose start is strictly greater than 'left'
        auto it = intervals.upper_bound(left);

        // If 'it' is not the beginning and the previous interval's end overlaps or touches 'left',
        // then we should start merging from that previous interval.
        if (it != intervals.begin()) {
            auto prev_it = std::prev(it);
            if (prev_it->second >= left) {
                it = prev_it; // Adjust 'it' to point to the overlapping previous interval
            }
        }
        // Now 'it' points to the first interval that potentially overlaps with [left, right]
        // (or intervals.end() if no such interval exists, or the first interval if it's the only one that could overlap from the left)

        // Iterate and merge all overlapping intervals
        while (it != intervals.end() && it->first <= right) {
            left = std::min(left, it->first);
            right = std::max(right, it->second);
            total_count -= (it->second - it->first + 1); // Subtract length of the interval being merged
            it = intervals.erase(it); // Erase the interval and move 'it' to the next element
        }

        // Insert the new merged interval
        intervals[left] = right;
        total_count += (right - left + 1); // Add length of the new merged interval
    }

    int count() {
        return static_cast<int>(total_count);
    }
};