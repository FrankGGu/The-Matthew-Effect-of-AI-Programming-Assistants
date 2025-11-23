#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string convertToBase7(int num) {
        if (num == 0) {
            return "0";
        }
        bool negative = num < 0;
        if (negative) {
            num = -num;
        }
        vector<char> digits;
        while (num > 0) {
            digits.push_back('0' + num % 7);
            num /= 7;
        }
        string result;
        if (negative) {
            result += '-';
        }
        for (int i = digits.size() - 1; i >= 0; --i) {
            result += digits[i];
        }
        return result;
    }
};