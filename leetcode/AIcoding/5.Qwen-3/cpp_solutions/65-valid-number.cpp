#include <iostream>
#include <vector>
#include <cctype>
#include <string>

using namespace std;

class Solution {
public:
    bool isNumber(string s) {
        bool numeric = true;
        int i = 0;
        if (s[i] == '+' || s[i] == '-') i++;
        if (i == s.size()) return false;
        while (i < s.size() && isdigit(s[i])) i++;
        if (i < s.size() && s[i] == '.') i++;
        while (i < s.size() && isdigit(s[i])) i++;
        if (i < s.size() && (s[i] == 'e' || s[i] == 'E')) {
            i++;
            if (i == s.size()) return false;
            if (s[i] == '+' || s[i] == '-') i++;
            while (i < s.size() && isdigit(s[i])) i++;
        }
        return i == s.size();
    }
};