#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    bool checkPalindrome(string s, int left, int right) {
        while (left < right) {
            if (s[left] != s[right]) return false;
            left++;
            right--;
        }
        return true;
    }

    bool canSplit(string s, string t) {
        int n = s.length();
        for (int i = 0; i < n; i++) {
            if (checkPalindrome(s, 0, i) && checkPalindrome(t, i + 1, n - 1)) return true;
            if (checkPalindrome(t, 0, i) && checkPalindrome(s, i + 1, n - 1)) return true;
        }
        return false;
    }

    bool checkIfCanMakePalindromeBySplittingIntoTwo(string s, string t) {
        return canSplit(s, t);
    }
};