#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string smallestPalindrome(string s) {
        vector<int> count(26, 0);
        for (char c : s) {
            count[c - 'a']++;
        }

        int odd = 0;
        char odd_char = '\0';
        for (int i = 0; i < 26; ++i) {
            if (count[i] % 2 != 0) {
                odd++;
                odd_char = 'a' + i;
            }
        }

        if (odd > 1) {
            return "";
        }

        string half;
        for (int i = 0; i < 26; ++i) {
            half += string(count[i] / 2, 'a' + i);
        }

        string palindrome = half;
        if (odd == 1) {
            palindrome += odd_char;
        }
        reverse(half.begin(), half.end());
        palindrome += half;

        return palindrome;
    }
};