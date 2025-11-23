#include <map>

class MyCalendarThree {
public:
    MyCalendarThree() {}

    int book(int start, int end) {
        events[start]++;
        events[end]--;
        int ongoing = 0, maxOverlaps = 0;
        for (auto& event : events) {
            ongoing += event.second;
            maxOverlaps = max(maxOverlaps, ongoing);
        }
        return maxOverlaps;
    }

private:
    std::map<int, int> events;
};