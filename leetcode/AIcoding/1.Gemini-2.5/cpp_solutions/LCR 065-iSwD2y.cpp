#include <string>
#include <vector>
#include <unordered_set>
#include <algorithm>

class Solution {
public:
    int minimumLengthEncoding(std::vector<std::string>& words) {
        std::unordered_set<std::string> s(words.begin(), words.end());
        for (const std::string& word : words) {
            for (size_t i = 1; i < word.length(); ++i) {
                s.erase(word.substr(i));
            }
        }

        int total_length = 0;
        for (const std::string& word : s) {
            total_length += word.length() + 1;
        }
        return total_length;
    }
};