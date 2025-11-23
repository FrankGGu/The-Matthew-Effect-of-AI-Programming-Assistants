#include <set>

class MyCalendar {
private:
    std::set<std::pair<int, int>> booked;

public:
    MyCalendar() {

    }

    bool book(int start, int end) {
        auto it = booked.lower_bound({start, end});

        if (it != booked.end() && it->first < end) {
            return false;
        }

        if (it != booked.begin()) {
            it--;
            if (start < it->second) {
                return false;
            }
        }

        booked.insert({start, end});
        return true;
    }
};