#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    int dayOfYear(std::string date) {
        int year = std::stoi(date.substr(0, 4));
        int month = std::stoi(date.substr(5, 2));
        int day = std::stoi(date.substr(8, 2));

        std::vector<int> daysInMonth = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

        bool isLeap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
        if (isLeap) {
            daysInMonth[2] = 29;
        }

        int totalDays = 0;
        for (int i = 1; i < month; ++i) {
            totalDays += daysInMonth[i];
        }

        totalDays += day;

        return totalDays;
    }
};