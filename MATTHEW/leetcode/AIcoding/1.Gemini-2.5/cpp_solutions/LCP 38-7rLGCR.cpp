#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int guardTheCastle(std::string s) {
        int n = s.length();
        int guards = 0;
        int i = 0;
        while (i < n) {
            if (s[i] == '.') {
                guards++;
                i += 3;
            } else {
                i++;
            }
        }
        return guards;
    }
};