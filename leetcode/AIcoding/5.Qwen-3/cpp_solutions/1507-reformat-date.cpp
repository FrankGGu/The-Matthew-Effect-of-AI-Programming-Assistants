#include <iostream>
#include <vector>
#include <string>
#include <map>

using namespace std;

class Solution {
public:
    string reformatDate(string date) {
        map<string, string> monthMap = {
            {"Jan", "01"},
            {"Feb", "02"},
            {"Mar", "03"},
            {"Apr", "04"},
            {"May", "05"},
            {"Jun", "06"},
            {"Jul", "07"},
            {"Aug", "08"},
            {"Sep", "09"},
            {"Oct", "10"},
            {"Nov", "11"},
            {"Dec", "12"}
        };

        int spaceIndex = date.find(' ');
        string dayStr = date.substr(0, spaceIndex);
        string monthStr = date.substr(spaceIndex + 1, 3);
        string yearStr = date.substr(date.rfind(' ') + 1);

        string day;
        for (char c : dayStr) {
            if (isdigit(c)) {
                day += c;
            }
        }

        if (day.length() == 1) {
            day = "0" + day;
        }

        return yearStr + "-" + monthMap[monthStr] + "-" + day;
    }
};