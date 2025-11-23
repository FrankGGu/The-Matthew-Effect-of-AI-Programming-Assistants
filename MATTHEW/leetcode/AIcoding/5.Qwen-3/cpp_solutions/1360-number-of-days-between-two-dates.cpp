#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int daysBetweenDates(string date1, string date2) {
        int y1 = stoi(date1.substr(0, 4));
        int m1 = stoi(date1.substr(5, 2));
        int d1 = stoi(date1.substr(8, 2));

        int y2 = stoi(date2.substr(0, 4));
        int m2 = stoi(date2.substr(5, 2));
        int d2 = stoi(date2.substr(8, 2));

        return abs(daysSinceEpoch(y1, m1, d1) - daysSinceEpoch(y2, m2, d2));
    }

private:
    int daysSinceEpoch(int year, int month, int day) {
        if (month < 3) {
            year--;
            month += 12;
        }
        int A = year / 100;
        int B = 2 - A + (A / 4);
        int C = 365 * year + (year / 4) - (year / 100) + (year / 400);
        int D = (153 * (month - 2) + 2) / 5;
        return C + D + day + 1721119;
    }
};