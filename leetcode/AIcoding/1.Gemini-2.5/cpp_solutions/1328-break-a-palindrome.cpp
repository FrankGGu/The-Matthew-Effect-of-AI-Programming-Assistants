#include <string>
#include <vector>

class Solution {
public:
    std::string breakPalindrome(std::string palindrome) {
        int n = palindrome.length();
        if (n <= 1) {
            return "";
        }

        for (int i = 0; i < n / 2; ++i) {
            if (palindrome[i] != 'a') {
                palindrome[i] = 'a';
                return palindrome;
            }
        }

        palindrome[n - 1] = 'b';
        return palindrome;
    }
};