#include <string>
#include <vector>

class Solution {
public:
    std::string dayOfTheWeek(int day, int month, int year) {
        std::vector<std::string> days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
        int t[] = {0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4};
        year -= month < 3;
        return days[(year + year/4 - year/100 + year/400 + t[month-1] + day) % 7];
    }
};