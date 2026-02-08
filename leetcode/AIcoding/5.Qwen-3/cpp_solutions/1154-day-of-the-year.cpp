#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int dayOfYear(string date) {
        vector<int> daysInMonth = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        int year, month, day;
        sscanf(date.c_str(), "%d-%d-%d", &year, &month, &day);

        if (month > 1 && (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))) {
            daysInMonth[1] = 29;
        }

        int dayOfYear = 0;
        for (int i = 0; i < month - 1; ++i) {
            dayOfYear += daysInMonth[i];
        }
        dayOfYear += day;

        return dayOfYear;
    }
};