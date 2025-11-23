#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int minLengthAfterRemovingSubstrings(string s) {
        string temp = s;
        bool changed;
        do {
            changed = false;
            for (int i = 0; i < temp.length() - 1; ++i) {
                if ((temp[i] == 'A' && temp[i + 1] == 'B') || (temp[i] == 'C' && temp[i + 1] == 'D')) {
                    temp.erase(i, 2);
                    changed = true;
                    break;
                }
            }
        } while (changed);
        return temp.length();
    }
};