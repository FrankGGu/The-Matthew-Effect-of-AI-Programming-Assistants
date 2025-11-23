#include <string>
#include <sstream>
#include <algorithm>

class Solution {
public:
    std::string capitalizeTitle(std::string title) {
        std::string result = "";
        std::string word;
        std::stringstream ss(title);

        while (ss >> word) {
            if (word.length() <= 2) {
                for (char &c : word) {
                    c = std::tolower(static_cast<unsigned char>(c));
                }
            } else {
                word[0] = std::toupper(static_cast<unsigned char>(word[0]));
                for (size_t i = 1; i < word.length(); ++i) {
                    word[i] = std::tolower(static_cast<unsigned char>(word[i]));
                }
            }
            result += word + " ";
        }

        if (!result.empty()) {
            result.pop_back();
        }

        return result;
    }
};