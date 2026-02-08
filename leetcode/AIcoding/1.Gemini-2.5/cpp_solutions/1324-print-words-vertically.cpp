#include <vector>
#include <string>
#include <sstream>
#include <algorithm>

class Solution {
public:
    std::vector<std::string> printVertically(std::string s) {
        std::stringstream ss(s);
        std::string word;
        std::vector<std::string> words;
        size_t maxLength = 0;

        while (ss >> word) {
            words.push_back(word);
            maxLength = std::max(maxLength, word.length());
        }

        std::vector<std::string> result(maxLength);
        for (const auto& w : words) {
            for (size_t j = 0; j < maxLength; ++j) {
                if (j < w.length()) {
                    result[j] += w[j];
                } else {
                    result[j] += ' ';
                }
            }
        }

        for (auto& row : result) {
            size_t last = row.find_last_not_of(' ');
            if (std::string::npos != last) {
                row.erase(last + 1);
            }
        }

        return result;
    }
};