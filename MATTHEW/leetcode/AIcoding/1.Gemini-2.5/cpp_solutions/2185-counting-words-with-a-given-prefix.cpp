#include <vector>
#include <string>

class Solution {
public:
    int prefixCount(std::vector<std::string>& words, std::string pref) {
        int count = 0;
        for (const std::string& word : words) {
            if (word.rfind(pref, 0) == 0) {
                count++;
            }
        }
        return count;
    }
};