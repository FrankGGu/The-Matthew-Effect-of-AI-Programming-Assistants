#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string convertToTitle(int columnNumber) {
        string title = "";
        while (columnNumber > 0) {
            int remainder = columnNumber % 26;
            if (remainder == 0) {
                title = 'Z' + title;
                columnNumber = columnNumber / 26 - 1;
            } else {
                title = char('A' + remainder - 1) + title;
                columnNumber = columnNumber / 26;
            }
        }
        return title;
    }
};