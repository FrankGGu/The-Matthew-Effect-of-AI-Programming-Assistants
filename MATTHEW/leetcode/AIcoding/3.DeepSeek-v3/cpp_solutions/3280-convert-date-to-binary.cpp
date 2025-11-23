#include <string>
#include <bitset>

using namespace std;

class Solution {
public:
    string convertDateToBinary(string date) {
        int year = stoi(date.substr(0, 4));
        int month = stoi(date.substr(5, 2));
        int day = stoi(date.substr(8, 2));

        string yearBinary = bitset<16>(year).to_string();
        string monthBinary = bitset<8>(month).to_string();
        string dayBinary = bitset<8>(day).to_string();

        return yearBinary + monthBinary + dayBinary;
    }
};