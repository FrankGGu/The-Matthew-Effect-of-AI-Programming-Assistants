#include <string>
#include <cctype>

class Solution {
public:
    std::string capitalizeFirstLetter(std::string s) {
        bool capitalizeNext = true;

        for (int i = 0; i < s.length(); ++i) {
            if (std::isspace(static_cast<unsigned char>(s[i]))) {
                capitalizeNext = true;
            } else if (std::isalpha(static_cast<unsigned char>(s[i]))) {
                if (capitalizeNext) {
                    s[i] = std::toupper(static_cast<unsigned char>(s[i]));
                    capitalizeNext = false;
                } else {
                    s[i] = std::tolower(static_cast<unsigned char>(s[i]));
                }
            } else {
                capitalizeNext = false;
            }
        }
        return s;
    }
};