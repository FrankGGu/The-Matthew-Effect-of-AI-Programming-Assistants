#include <map>

class MyCalendar {
private:
    std::map<int, int> bookings;

public:
    MyCalendar() {
    }

    bool book(int start, int end) {
        auto it = bookings.lower_bound(start);

        if (it != bookings.end() && it->first < end) {
            return false;
        }

        if (it != bookings.begin() && std::prev(it)->second > start) {
            return false;
        }

        bookings[start] = end;
        return true;
    }
};