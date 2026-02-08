#include <unordered_map>
#include <string>

class Solution {
public:
    bool canConstruct(std::string ransomNote, std::string magazine) {
        std::unordered_map<char, int> charCount;
        for (char c : magazine) {
            charCount[c]++;
        }
        for (char c : ransomNote) {
            if (--charCount[c] < 0) {
                return false;
            }
        }
        return true;
    }
};