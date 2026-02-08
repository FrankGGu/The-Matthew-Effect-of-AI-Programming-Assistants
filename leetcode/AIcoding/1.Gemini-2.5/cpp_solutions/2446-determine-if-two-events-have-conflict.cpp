#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int timeToMinutes(const std::string& timeStr) {
        int hours = std::stoi(timeStr.substr(0, 2));
        int minutes = std::stoi(timeStr.substr(3, 2));
        return hours * 60 + minutes;
    }

    bool haveConflict(std::vector<std::string>& event1, std::vector<std::string>& event2) {
        int s1 = timeToMinutes(event1[0]);
        int e1 = timeToMinutes(event1[1]);
        int s2 = timeToMinutes(event2[0]);
        int e2 = timeToMinutes(event2[1]);

        return std::max(s1, s2) <= std::min(e1, e2);
    }
};