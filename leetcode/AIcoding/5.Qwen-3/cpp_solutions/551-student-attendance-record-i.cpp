#include <iostream>
#include <string>

using namespace std;

class Solution {
public:
    bool checkRecord(string s) {
        int countA = 0;
        for (int i = 0; i < s.length(); ++i) {
            if (s[i] == 'A') {
                countA++;
                if (countA >= 2) return false;
            }
            if (i > 0 && s[i] == 'L' && s[i-1] == 'L' && i < s.length() - 1 && s[i+1] == 'L') {
                return false;
            }
        }
        return true;
    }
};