#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    bool checkStrings(std::string s1, std::string s2) {
        std::vector<char> s1_even_chars;
        std::vector<char> s1_odd_chars;
        std::vector<char> s2_even_chars;
        std::vector<char> s2_odd_chars;

        int n = s1.length();

        for (int i = 0; i < n; ++i) {
            if (i % 2 == 0) { // Even index
                s1_even_chars.push_back(s1[i]);
                s2_even_chars.push_back(s2[i]);
            } else { // Odd index
                s1_odd_chars.push_back(s1[i]);
                s2_odd_chars.push_back(s2[i]);
            }
        }

        std::sort(s1_even_chars.begin(), s1_even_chars.end());
        std::sort(s1_odd_chars.begin(), s1_odd_chars.end());
        std::sort(s2_even_chars.begin(), s2_even_chars.end());
        std::sort(s2_odd_chars.begin(), s2_odd_chars.end());

        return (s1_even_chars == s2_even_chars) && (s1_odd_chars == s2_odd_chars);
    }
};