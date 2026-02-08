#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string dayOfTheWeek(int day, int month, int year) {
        vector<string> days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
        vector<int> months = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

        int totalDays = 0;
        for (int y = 1970; y < year; ++y) {
            totalDays += 365 + (isLeapYear(y) ? 1 : 0);
        }

        for (int m = 0; m < month - 1; ++m) {
            totalDays += months[m];
        }

        if (month > 2 && isLeapYear(year)) {
            totalDays += 1;
        }

        totalDays += day - 1;

        return days[totalDays % 7];
    }

private:
    bool isLeapYear(int year) {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    }
};