#include <string>
#include <vector>
#include <algorithm>
#include <map>

class Solution {
public:
    bool isPalindrome(const std::string& str) {
        int left = 0;
        int right = str.length() - 1;
        while (left < right) {
            if (str[left] != str[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }

    int maxProduct(std::string s) {
        int n = s.length();
        std::map<int, int> palindrome_lengths;

        for (int i = 1; i < (1 << n); ++i) {
            std::string sub_s = "";
            for (int j = 0; j < n; ++j) {
                if ((i >> j) & 1) {
                    sub_s += s[j];
                }
            }
            if (isPalindrome(sub_s)) {
                palindrome_lengths[i] = sub_s.length();
            }
        }

        int max_prod = 0;

        for (auto const& [mask1, len1] : palindrome_lengths) {
            for (auto const& [mask2, len2] : palindrome_lengths) {
                if ((mask1 & mask2) == 0) {
                    max_prod = std::max(max_prod, len1 * len2);
                }
            }
        }

        return max_prod;
    }
};