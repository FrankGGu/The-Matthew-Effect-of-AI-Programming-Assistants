#include <string>
#include <vector>
#include <sstream>
#include <algorithm>

class Solution {
public:
    std::string sortSentence(std::string s) {
        std::vector<std::string> words(10); 
        std::stringstream ss(s);
        std::string token;
        int max_index = 0;

        while (ss >> token) {
            char lastChar = token.back();
            int index = lastChar - '0';
            words[index] = token.substr(0, token.length() - 1);
            if (index > max_index) {
                max_index = index;
            }
        }

        std::string result = "";
        for (int i = 1; i <= max_index; ++i) {
            result += words[i];
            if (i < max_index) {
                result += " ";
            }
        }
        return result;
    }
};