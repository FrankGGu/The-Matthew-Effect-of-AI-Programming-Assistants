class Solution {
public:
    string dayOfTheWeek(int day, int month, int year) {
        static const vector<string> days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
        if (month < 3) {
            month += 12;
            year--;
        }
        int k = year % 100;
        int j = year / 100;
        int f = day + (13 * (month + 1)) / 5 + k + k / 4 + j / 4 + 5 * j;
        return days[f % 7];
    }
};