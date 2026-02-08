#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool checkIfValid(string s) {
        int open = 0;
        int close = 0;
        for (char c : s) {
            if (c == '(') {
                open++;
            } else {
                close++;
            }
            if (close > open) {
                return false;
            }
        }
        return open == close;
    }
};