class Solution {
public:
    int daysBetweenDates(string date1, string date2) {
        return abs(getDays(date1) - getDays(date2));
    }

private:
    int getDays(string date) {
        int year = stoi(date.substr(0, 4));
        int month = stoi(date.substr(5, 2));
        int day = stoi(date.substr(8, 2));

        int total = 0;
        for (int y = 1971; y < year; ++y) {
            total += isLeap(y) ? 366 : 365;
        }

        for (int m = 1; m < month; ++m) {
            total += daysInMonth(year, m);
        }

        total += day;
        return total;
    }

    bool isLeap(int year) {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    }

    int daysInMonth(int year, int month) {
        if (month == 2) {
            return isLeap(year) ? 29 : 28;
        }
        if (month == 4 || month == 6 || month == 9 || month == 11) {
            return 30;
        }
        return 31;
    }
};