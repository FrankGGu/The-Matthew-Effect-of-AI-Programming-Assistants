#include <iostream>
#include <string>

using namespace std;

class Solution {
public:
    int lengthOfLastWord(string s) {
        int length = 0;
        for (int i = s.length() - 1; i >= 0; --i) {
            if (s[i] == ' ') {
                if (length > 0) {
                    break;
                }
            } else {
                ++length;
            }
        }
        return length;
    }
};