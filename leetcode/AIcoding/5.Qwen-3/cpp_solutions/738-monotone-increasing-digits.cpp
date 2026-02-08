#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string monotoneIncreasingDigits(string s) {
        int n = s.size();
        int i = 0;
        while (i < n - 1 && s[i] <= s[i + 1]) {
            ++i;
        }
        if (i == n - 1) {
            return s;
        }
        while (i >= 0 && s[i] > s[i + 1]) {
            --i;
        }
        ++i;
        while (i < n) {
            s[i] = '0';
            ++i;
        }
        return s;
    }
};