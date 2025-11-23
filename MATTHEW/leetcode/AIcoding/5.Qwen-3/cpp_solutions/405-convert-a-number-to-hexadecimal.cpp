#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string toHex(int num) {
        if (num == 0) return "0";
        string hexDigits = "0123456789abcdef";
        string result;
        while (num != 0) {
            int index = num & 15;
            result = hexDigits[index] + result;
            num >>= 4;
        }
        return result;
    }
};