#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string firstPalindrome(string& s) {
        for (int i = 0; i < s.length(); ++i) {
            int left = 0;
            int right = i;
            bool isPalindrome = true;
            while (left < right) {
                if (s[left] != s[right]) {
                    isPalindrome = false;
                    break;
                }
                ++left;
                --right;
            }
            if (isPalindrome) {
                return s.substr(0, i + 1);
            }
        }
        return "";
    }
};