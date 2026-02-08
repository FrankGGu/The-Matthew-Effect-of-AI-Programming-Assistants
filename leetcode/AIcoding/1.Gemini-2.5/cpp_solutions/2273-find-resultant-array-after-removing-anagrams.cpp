#include <vector>
#include <string>
#include <algorithm>

class Solution {
private:
    bool areAnagrams(const std::string& s1, const std::string& s2) {
        if (s1.length() != s2.length()) {
            return false;
        }
        std::string temp1 = s1;
        std::string temp2 = s2;
        std::sort(temp1.begin(), temp1.end());
        std::sort(temp2.begin(), temp2.end());
        return temp1 == temp2;
    }

public:
    std::vector<std::string> removeAnagrams(std::vector<std::string>& words) {
        std::vector<std::string> result;

        if (words.empty()) {
            return result;
        }

        result.push_back(words[0]);

        for (size_t i = 1; i < words.size(); ++i) {
            if (!areAnagrams(words[i], result.back())) {
                result.push_back(words[i]);
            }
        }

        return result;
    }
};