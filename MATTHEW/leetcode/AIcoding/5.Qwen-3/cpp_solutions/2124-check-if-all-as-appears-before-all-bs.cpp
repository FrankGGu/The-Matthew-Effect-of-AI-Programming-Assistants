#include <iostream>
#include <string>

using namespace std;

class Solution {
public:
    bool checkString(string s) {
        bool aSeen = false;
        for (char c : s) {
            if (c == 'a') {
                aSeen = true;
            } else if (c == 'b') {
                if (aSeen) {
                    return false;
                }
            }
        }
        return true;
    }
};