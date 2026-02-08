#include <map>

class MyCalendarTwo {
public:
    MyCalendarTwo() {

    }

    bool book(int start, int end) {
        count[start]++;
        count[end]--;

        int ongoing = 0;
        for (auto const& [time, delta] : count) {
            ongoing += delta;
            if (ongoing >= 3) {
                count[start]--;
                count[end]++;
                if (count[start] == 0) count.erase(start);
                if (count[end] == 0) count.erase(end);
                return false;
            }
        }
        return true;
    }

private:
    std::map<int, int> count;
};