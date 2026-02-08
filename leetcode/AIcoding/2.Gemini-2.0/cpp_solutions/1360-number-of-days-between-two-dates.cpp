#include <string>

using namespace std;

class Solution {
public:
    int daysBetweenDates(string date1, string date2) {
        return abs(daysFrom1970(date1) - daysFrom1970(date2));
    }

private:
    int daysFrom1970(string date) {
        int year = stoi(date.substr(0, 4));
        int month = stoi(date.substr(5, 2));
        int day = stoi(date.substr(8, 2));

        int days = 0;
        for (int y = 1970; y < year; ++y) {
            days += isLeapYear(y) ? 366 : 365;
        }

        int daysInMonth[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        if (isLeapYear(year)) {
            daysInMonth[2] = 29;
        }

        for (int m = 1; m < month; ++m) {
            days += daysInMonth[m];
        }

        days += day;
        return days;
    }

    bool isLeapYear(int year) {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    }
};