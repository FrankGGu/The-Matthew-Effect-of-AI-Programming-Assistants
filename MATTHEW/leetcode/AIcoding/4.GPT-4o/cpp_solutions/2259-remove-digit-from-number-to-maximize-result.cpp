class Solution {
public:
    string deleteDigit(string number, char digit) {
        string result = "";
        for (int i = 0; i < number.size(); i++) {
            if (number[i] == digit) {
                string temp = number.substr(0, i) + number.substr(i + 1);
                if (temp > result) {
                    result = temp;
                }
            }
        }
        return result.empty() ? number.substr(0, number.size() - 1) : result;
    }
};