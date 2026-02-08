#include <iostream>
#include <vector>
#include <string>
#include <sstream>

class Solution {
public:
    int countValidWords(std::string sentence) {
        std::istringstream iss(sentence);
        std::string word;
        int count = 0;

        while (iss >> word) {
            bool valid = true;
            for (int i = 0; i < word.length(); ++i) {
                if (word[i] == '-') {
                    if (i == 0 || i == word.length() - 1 || !isalpha(word[i-1]) || !isalpha(word[i+1])) {
                        valid = false;
                        break;
                    }
                } else if (!isalpha(word[i])) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                ++count;
            }
        }

        return count;
    }
};