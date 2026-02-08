#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool checkZeroOne(string s) {
        int maxOne = 0, maxZero = 0;
        int currentOne = 0, currentZero = 0;

        for (char c : s) {
            if (c == '1') {
                currentOne++;
                currentZero = 0;
                maxOne = max(maxOne, currentOne);
            } else {
                currentZero++;
                currentOne = 0;
                maxZero = max(maxZero, currentZero);
            }
        }

        return maxOne > maxZero;
    }
};