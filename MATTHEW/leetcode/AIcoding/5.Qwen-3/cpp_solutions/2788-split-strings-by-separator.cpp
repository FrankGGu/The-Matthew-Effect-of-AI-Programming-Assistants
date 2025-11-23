#include <iostream>
#include <vector>
#include <string>

class Solution {
public:
    std::vector<std::string> splitWordsBySeparator(std::vector<std::string>& words, char separator) {
        std::vector<std::string> result;
        for (const auto& word : words) {
            std::string current;
            for (char c : word) {
                if (c == separator) {
                    if (!current.empty()) {
                        result.push_back(current);
                        current.clear();
                    }
                } else {
                    current += c;
                }
            }
            if (!current.empty()) {
                result.push_back(current);
            }
        }
        return result;
    }
};