#include <string>
#include <sstream>
#include <algorithm>

class Solution {
public:
    std::string convertDateToBinary(std::string date) {
        int year, month, day;
        std::stringstream ss(date);
        char dash;

        ss >> year >> dash >> month >> dash >> day;

        long long date_as_int = (long long)year * 10000 + (long long)month * 100 + (long long)day;

        if (date_as_int == 0) {
            return "0";
        }

        std::string binaryString = "";
        while (date_as_int > 0) {
            binaryString = (date_as_int % 2 == 0 ? "0" : "1") + binaryString;
            date_as_int /= 2;
        }

        return binaryString;
    }
};