#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool canBeEqual(string target, string s) {
        int i = 0, j = 0;
        while (i < s.length() && j < target.length()) {
            if (s[i] == ' ') {
                ++i;
                continue;
            }
            if (target[j] == ' ') {
                ++j;
                continue;
            }
            if (s[i] != target[j]) {
                return false;
            }
            ++i;
            ++j;
        }
        while (i < s.length()) {
            if (s[i] != ' ') return false;
            ++i;
        }
        while (j < target.length()) {
            if (target[j] != ' ') return false;
            ++j;
        }
        return true;
    }
};