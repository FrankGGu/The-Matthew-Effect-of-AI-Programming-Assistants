#include <string>
#include <vector>

class Solution {
public:
    int countPrefixes(std::vector<std::string>& words, std::string s) {
        int count = 0;
        for (const std::string& word : words) {
            if (s.rfind(word, 0) == 0) {
                count++;
            }
        }
        return count;
    }
};