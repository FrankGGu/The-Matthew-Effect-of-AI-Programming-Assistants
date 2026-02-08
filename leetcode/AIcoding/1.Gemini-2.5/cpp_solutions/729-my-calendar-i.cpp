#include <map>

class MyCalendar {
private:
    std::map<int, int> calendar;

public:
    MyCalendar() {

    }

    bool book(int start, int end) {
        auto it = calendar.upper_bound(start);

        if (it != calendar.begin()) {
            auto prev_it = std::prev(it);
            if (prev_it->second > start) {
                return false;
            }
        }

        if (it != calendar.end()) {
            if (it->first < end) {
                return false;
            }
        }

        calendar[start] = end;
        return true;
    }
};