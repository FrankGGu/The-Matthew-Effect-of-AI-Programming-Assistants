#include <map>

class MyCalendarThree {
public:
    MyCalendarThree() {

    }

    int book(int start, int end) {
        timeline[start]++;
        timeline[end]--;

        int ongoing = 0;
        int maxOverlap = 0;
        for (auto const& [time, delta] : timeline) {
            ongoing += delta;
            maxOverlap = std::max(maxOverlap, ongoing);
        }
        return maxOverlap;
    }

private:
    std::map<int, int> timeline;
};