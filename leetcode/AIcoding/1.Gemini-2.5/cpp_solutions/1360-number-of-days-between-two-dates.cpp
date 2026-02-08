#include <string>
#include <vector>
#include <numeric>
#include <cmath>

class Solution {
public:
    int daysBetweenDates(std::string date1, std::string date2) {
        return std::abs(daysFrom1971(date1) - daysFrom1971(date2));
    }

private:
    bool isLeap(int year) {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    }

    int daysFrom1971(const std::string& date) {
        int year = std::stoi(date.substr(0, 4));
        int month = std::stoi(date.substr(5, 2));
        int day = std::stoi(date.substr(8, 2));

        int total_days = 0;

        for (int y = 1971; y < year; ++y) {
            total_days += isLeap(y) ? 366 : 365;
        }

        std::vector<int> days_in_month = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        if (isLeap(year)) {
            days_in_month[2] = 29;
        }

        for (int m = 1; m < month; ++m) {
            total_days += days_in_month[m];
        }

        total_days += day;

        return total_days;
    }
};