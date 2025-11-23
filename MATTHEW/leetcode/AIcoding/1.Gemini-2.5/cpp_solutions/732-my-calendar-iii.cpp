#include <map>
#include <algorithm>

class MyCalendarThree {
private:
    std::map<int, int> timeline;

public:
    MyCalendarThree() {

    }

    int book(int start, int end) {
        timeline[start]++;
        timeline[end]--;

        int current_overlap = 0;
        int max_overlap = 0;

        for (auto const& [time, change] : timeline) {
            current_overlap += change;
            max_overlap = std::max(max_overlap, current_overlap);
        }

        return max_overlap;
    }
};