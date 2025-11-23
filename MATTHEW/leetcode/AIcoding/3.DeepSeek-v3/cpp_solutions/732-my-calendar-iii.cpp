class MyCalendarThree {
private:
    map<int, int> timeline;

public:
    MyCalendarThree() {

    }

    int book(int start, int end) {
        timeline[start]++;
        timeline[end]--;
        int ongoing = 0, k = 0;
        for (const auto& event : timeline) {
            ongoing += event.second;
            if (ongoing > k) {
                k = ongoing;
            }
        }
        return k;
    }
};