#include <string>
#include <algorithm>
#include <cctype>

class Solution {
public:
    std::string licenseKeyFormatting(std::string s, int k) {
        std::string cleaned_s;
        cleaned_s.reserve(s.length());

        for (char c : s) {
            if (c != '-') {
                cleaned_s.push_back(std::toupper(c));
            }
        }

        if (cleaned_s.empty()) {
            return "";
        }

        std::string result;
        // Max possible length: original cleaned length + (num_groups - 1) dashes
        // Num groups is roughly cleaned_s.length() / k
        result.reserve(cleaned_s.length() + (cleaned_s.length() + k - 1) / k); 

        int count = 0;
        for (int i = cleaned_s.length() - 1; i >= 0; --i) {
            result.push_back(cleaned_s[i]);
            count++;
            if (count == k && i > 0) {
                result.push_back('-');
                count = 0;
            }
        }

        std::reverse(result.begin(), result.end());
        return result;
    }
};