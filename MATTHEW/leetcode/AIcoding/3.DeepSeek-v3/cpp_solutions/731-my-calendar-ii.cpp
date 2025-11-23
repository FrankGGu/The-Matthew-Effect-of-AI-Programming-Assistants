class MyCalendarTwo {
private:
    map<int, int> events;

public:
    MyCalendarTwo() {

    }

    bool book(int start, int end) {
        events[start]++;
        events[end]--;
        int active = 0;
        for (auto it = events.begin(); it != events.end(); ++it) {
            active += it->second;
            if (active >= 3) {
                events[start]--;
                events[end]++;
                return false;
            }
        }
        return true;
    }
};