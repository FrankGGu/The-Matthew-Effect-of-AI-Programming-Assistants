#include <iostream>
#include <vector>
#include <string>
#include <sstream>
#include <map>

using namespace std;

class Solution {
public:
    int countDaysTogether(string arriveAlice, string departAlice, string arriveBob, string departBob) {
        map<string, int> dayMap;
        vector<string> days = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};

        for (int i = 0; i < 12; ++i) {
            int daysInMonth = 31;
            if (i == 1) daysInMonth = 28;
            else if (i == 3 || i == 5 || i == 8 || i == 10) daysInMonth = 30;
            for (int d = 1; d <= daysInMonth; ++d) {
                string dayStr = days[i] + to_string(d);
                dayMap[dayStr] = 0;
            }
        }

        auto parseDate = [&](string date) {
            stringstream ss(date);
            string month, day;
            getline(ss, month, ' ');
            getline(ss, day);
            return month + day;
        };

        string startA = parseDate(arriveAlice);
        string endA = parseDate(departAlice);
        string startB = parseDate(arriveBob);
        string endB = parseDate(departBob);

        for (auto& [day, val] : dayMap) {
            if ((day >= startA && day <= endA) || (day >= startB && day <= endB)) {
                dayMap[day]++;
            }
        }

        int count = 0;
        for (auto& [day, val] : dayMap) {
            if (val == 2) {
                count++;
            }
        }

        return count;
    }
};