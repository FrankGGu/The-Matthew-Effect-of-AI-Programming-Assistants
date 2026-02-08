#include <string>
#include <algorithm>
#include <vector>

class Solution {
public:
    int maximumGain(std::string s, int x, int y) {
        int total_score = 0;
        std::string high_p_sub = (x > y) ? "ab" : "ba";
        std::string low_p_sub = (x > y) ? "ba" : "ab";
        int high_p_score = std::max(x, y);
        int low_p_score = std::min(x, y);

        std::string temp_s;
        for (char c : s) {
            if (!temp_s.empty() && temp_s.back() == high_p_sub[0] && c == high_p_sub[1]) {
                temp_s.pop_back();
                total_score += high_p_score;
            } else {
                temp_s.push_back(c);
            }
        }

        std::string final_s;
        for (char c : temp_s) {
            if (!final_s.empty() && final_s.back() == low_p_sub[0] && c == low_p_sub[1]) {
                final_s.pop_back();
                total_score += low_p_score;
            } else {
                final_s.push_back(c);
            }
        }

        return total_score;
    }
};