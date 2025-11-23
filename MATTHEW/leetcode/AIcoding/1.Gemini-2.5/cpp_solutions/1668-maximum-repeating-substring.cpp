#include <string>

class Solution {
public:
    int maxRepeating(std::string sequence, std::string word) {
        int k = 0;
        std::string current_word = "";

        while (true) {
            current_word += word;
            if (sequence.find(current_word) != std::string::npos) {
                k++;
            } else {
                break;
            }
        }

        return k;
    }
};