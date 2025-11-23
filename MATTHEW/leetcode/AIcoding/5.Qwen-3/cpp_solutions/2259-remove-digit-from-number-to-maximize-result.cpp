#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string removeDigit(string number, char digit) {
        int n = number.length();
        int index = -1;
        for (int i = 0; i < n; ++i) {
            if (number[i] == digit) {
                index = i;
                if (i < n - 1 && number[i + 1] > digit) {
                    break;
                }
            }
        }
        return number.substr(0, index) + number.substr(index + 1);
    }
};