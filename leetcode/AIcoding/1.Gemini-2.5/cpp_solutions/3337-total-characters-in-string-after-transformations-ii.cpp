#include <string>

class Solution {
public:
    long long totalCharacters(std::string s, int k, char ch) {
        if (k == 0) {
            return s.length();
        }

        long long initial_len = s.length();
        int ascii_val = static_cast<int>(ch);
        int len_ascii_ch;

        if (ascii_val < 100) {
            len_ascii_ch = 2; 
        } else {
            len_ascii_ch = 3; 
        }

        long long count_ch = 0;
        for (char c : s) {
            if (c == ch) {
                count_ch++;
            }
        }

        long long final_length = count_ch * len_ascii_ch + (initial_len - count_ch);

        return final_length;
    }
};