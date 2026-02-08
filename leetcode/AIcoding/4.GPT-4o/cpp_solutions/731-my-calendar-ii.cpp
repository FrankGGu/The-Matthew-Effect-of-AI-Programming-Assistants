class MyCalendarTwo {
public:
    map<int, int> events;

    MyCalendarTwo() {}

    bool book(int start, int end) {
        events[start]++;
        events[end]--;
        int ongoing = 0;
        for (auto [time, count] : events) {
            ongoing += count;
            if (ongoing >= 3) {
                events[start]--;
                events[end]++;
                return false;
            }
        }
        return true;
    }
};