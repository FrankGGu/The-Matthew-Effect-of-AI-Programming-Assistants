class MyCalendar {
public:
    set<pair<int, int>> bookings;

    MyCalendar() {
    }

    bool book(int start, int end) {
        auto it = bookings.lower_bound({start, end});
        if (it != bookings.end() && it->first < end) return false;
        if (it != bookings.begin() && (--it)->second > start) return false;
        bookings.insert({start, end});
        return true;
    }
};