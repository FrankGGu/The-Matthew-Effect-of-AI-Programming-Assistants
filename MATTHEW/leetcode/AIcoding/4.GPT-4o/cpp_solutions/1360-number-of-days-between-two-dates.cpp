#include <iostream>
#include <string>
#include <sstream>
#include <vector>

using namespace std;

class Solution {
public:
    int daysBetweenDates(string date1, string date2) {
        return abs(countDays(date1) - countDays(date2));
    }

private:
    int countDays(string date) {
        int year, month, day;
        stringstream ss(date);
        char delimiter;
        ss >> year >> delimiter >> month >> delimiter >> day;

        int days = day;
        for (int i = 1; i < month; i++) {
            days += daysInMonth(i, year);
        }
        days += (year - 1971) * 365 + (year - 1971) / 4 - (year - 1971) / 100 + (year - 1971) / 400;
        return days;
    }

    int daysInMonth(int month, int year) {
        if (month == 2) {
            return (isLeapYear(year) ? 29 : 28);
        }
        return (month == 4 || month == 6 || month == 9 || month == 11) ? 30 : 31;
    }

    bool isLeapYear(int year) {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    }
};