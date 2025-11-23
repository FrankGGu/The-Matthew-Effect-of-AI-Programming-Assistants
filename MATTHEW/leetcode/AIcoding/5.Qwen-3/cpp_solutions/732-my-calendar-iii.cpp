#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    int book(int start, int end) {
        ++calendar[start];
        --calendar[end];
        int maxEvents = 0;
        int currentEvents = 0;
        for (auto& [time, delta] : calendar) {
            currentEvents += delta;
            maxEvents = max(maxEvents, currentEvents);
        }
        return maxEvents;
    }

private:
    map<int, int> calendar;
};