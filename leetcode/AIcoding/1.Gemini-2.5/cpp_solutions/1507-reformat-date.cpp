#include <string>
#include <vector>
#include <unordered_map>
#include <sstream>

class Solution {
public:
    std::string reformatDate(std::string date) {
        std::unordered_map<std::string, std::string> months = {
            {"Jan", "01"}, {"Feb", "02"}, {"Mar", "03"}, {"Apr", "04"}, 
            {"May", "05"}, {"Jun", "06"}, {"Jul", "07"}, {"Aug", "08"}, 
            {"Sep", "09"}, {"Oct", "10"}, {"Nov", "11"}, {"Dec", "12"}
        };

        std::string year, month, day;

        if (date.length() == 13) { // e.g., "20th Oct 2052"
            year = date.substr(9, 4);
            month = months[date.substr(5, 3)];
            day = date.substr(0, 2);
        } else { // e.g., "6th Jun 1933"
            year = date.substr(8, 4);
            month = months[date.substr(4, 3)];
            day = "0" + date.substr(0, 1);
        }

        return year + "-" + month + "-" + day;
    }
};