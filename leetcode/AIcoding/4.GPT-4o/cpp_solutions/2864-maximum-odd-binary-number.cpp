class Solution {
public:
    string maximumOddBinaryNumber(string s) {
        int countOne = 0;
        for (char c : s) {
            if (c == '1') countOne++;
        }
        if (countOne == 0) return "0";

        string result(countOne - 1, '1');
        result += '0';
        result += '1';

        return result;
    }
};