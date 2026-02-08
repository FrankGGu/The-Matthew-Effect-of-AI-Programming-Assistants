#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string reformatDate(string date) {
        unordered_map<string, string> monthMap = {
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

        string year = date.substr(date.size() - 4);
        string month = date.substr(date.size() - 8, 3);
        string dayStr = date.substr(0, date.size() - 9);
        int day = stoi(dayStr);
        string dayFormatted = (day < 10) ? "0" + to_string(day) : to_string(day);

        return year + "-" + monthMap[month] + "-" + dayFormatted;
    }
};