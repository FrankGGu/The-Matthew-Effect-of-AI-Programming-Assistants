#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countAsterisks(string s) {
        int count = 0;
        bool inVerticalLine = false;
        for (char c : s) {
            if (c == '|') {
                inVerticalLine = !inVerticalLine;
            } else if (!inVerticalLine && c == '*') {
                count++;
            }
        }
        return count;
    }
};