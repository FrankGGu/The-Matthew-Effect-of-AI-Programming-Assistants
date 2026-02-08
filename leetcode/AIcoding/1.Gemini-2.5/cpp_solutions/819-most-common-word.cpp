#include <string>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <sstream>
#include <algorithm>
#include <cctype>

class Solution {
public:
    std::string mostCommonWord(std::string paragraph, std::vector<std::string>& banned) {
        std::unordered_set<std::string> banned_set(banned.begin(), banned.end());

        for (char &c : paragraph) {
            c = isalpha(c) ? tolower(c) : ' ';
        }

        std::stringstream ss(paragraph);
        std::string word;
        std::unordered_map<std::string, int> counts;

        std::string result;
        int max_freq = 0;

        while (ss >> word) {
            if (banned_set.find(word) == banned_set.end()) {
                counts[word]++;
                if (counts[word] > max_freq) {
                    max_freq = counts[word];
                    result = word;
                }
            }
        }

        return result;
    }
};