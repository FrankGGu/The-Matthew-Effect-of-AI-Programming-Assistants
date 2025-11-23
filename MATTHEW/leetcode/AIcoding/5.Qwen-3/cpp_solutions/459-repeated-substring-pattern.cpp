#include <iostream>
#include <string>

using namespace std;

class Solution {
public:
    bool repeatedSubstringPattern(string s) {
        string doubled = s + s;
        return doubled.find(s, 1) != string::npos && doubled.find(s, 1) != s.length();
    }
};