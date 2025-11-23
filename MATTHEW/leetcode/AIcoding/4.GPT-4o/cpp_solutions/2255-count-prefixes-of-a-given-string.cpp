#include <vector>
#include <string>

class Solution {
public:
    int countPrefixes(std::vector<std::string>& words, std::string s) {
        int count = 0;
        for (const auto& word : words) {
            if (s.find(word) == 0) {
                count++;
            }
        }
        return count;
    }
};