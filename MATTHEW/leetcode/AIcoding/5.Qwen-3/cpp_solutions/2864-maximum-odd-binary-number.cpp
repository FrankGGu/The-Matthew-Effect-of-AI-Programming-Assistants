#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string maximumOddBinaryNumber(string s) {
        int countOne = 0;
        for (char c : s) {
            if (c == '1') {
                countOne++;
            }
        }
        string result;
        for (int i = 0; i < countOne - 1; ++i) {
            result += '1';
        }
        for (int i = 0; i < s.length() - countOne; ++i) {
            result += '0';
        }
        result += '1';
        return result;
    }
};