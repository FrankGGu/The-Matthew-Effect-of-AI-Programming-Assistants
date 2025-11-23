#include <string>
#include <cctype>
#include <algorithm>

class Solution {
public:
    std::string reverseOnlyLetters(std::string s) {
        int left = 0;
        int right = s.length() - 1;
        while (left < right) {
            if (!isalpha(s[left])) {
                left++;
            } else if (!isalpha(s[right])) {
                right--;
            } else {
                std::swap(s[left], s[right]);
                left++;
                right--;
            }
        }
        return s;
    }
};