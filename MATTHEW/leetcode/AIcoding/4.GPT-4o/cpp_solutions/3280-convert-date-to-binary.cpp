class Solution {
public:
    string convertDateToBinary(string date) {
        int day = stoi(date.substr(8, 2));
        int month = stoi(date.substr(5, 2));
        int year = stoi(date.substr(0, 4));

        string binaryDay = bitset<5>(day).to_string();
        string binaryMonth = bitset<4>(month).to_string();
        string binaryYear = bitset<7>(year - 2000).to_string();

        return binaryYear + " " + binaryMonth + " " + binaryDay;
    }
};