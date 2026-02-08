class MyCalendar {
private:
    vector<pair<int, int>> events;

public:
    MyCalendar() {

    }

    bool book(int start, int end) {
        for (auto &event : events) {
            if (start < event.second && end > event.first) {
                return false;
            }
        }
        events.push_back({start, end});
        return true;
    }
};