#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool isPalindrome(string s) {
        string cleaned_s = "";
        for (char c : s) {
            if (isalnum(c)) {
                cleaned_s += tolower(c);
            }
        }

        string reversed_s = cleaned_s;
        reverse(reversed_s.begin(), reversed_s.end());

        return cleaned_s == reversed_s;
    }
};