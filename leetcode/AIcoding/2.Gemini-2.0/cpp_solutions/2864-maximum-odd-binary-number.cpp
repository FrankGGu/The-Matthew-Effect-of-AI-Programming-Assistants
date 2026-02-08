#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string maximumOddBinaryNumber(string s) {
        int count_1 = 0;
        for (char c : s) {
            if (c == '1') {
                count_1++;
            }
        }

        string result = "";
        for (int i = 0; i < s.length() - 1; ++i) {
            if (count_1 > 1) {
                result += '1';
                count_1--;
            } else {
                result += '0';
            }
        }

        result += '1';

        return result;
    }
};