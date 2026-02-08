#include <iostream>
#include <string>

using namespace std;

class Solution {
public:
    int removePalindromeSub(string s) {
        if (s.empty()) return 0;
        bool isPalindrome = true;
        for (int i = 0; i < s.length() / 2; ++i) {
            if (s[i] != s[s.length() - 1 - i]) {
                isPalindrome = false;
                break;
            }
        }
        return isPalindrome ? 1 : 2;
    }
};