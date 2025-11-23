#include <string>
#include <sstream>

using namespace std;

class Solution {
public:
    string dateToBinary(string date) {
        int year = stoi(date.substr(0, 4));
        int month = stoi(date.substr(5, 2));
        int day = stoi(date.substr(8, 2));

        stringstream yearStream, monthStream, dayStream;
        yearStream << bitset<16>(year);
        monthStream << bitset<4>(month);
        dayStream << bitset<5>(day);

        return yearStream.str() + monthStream.str() + dayStream.str();
    }
};