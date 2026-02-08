#include <vector>
#include <string>
#include <algorithm> // For std::max

class Solution {
public:
    int mostWordsFound(std::vector<std::string>& sentences) {
        int max_words = 0;

        for (const std::string& sentence : sentences) {
            int current_words = 0;
            if (!sentence.empty()) {
                current_words = 1; // At least one word if the sentence is not empty
                for (char c : sentence) {
                    if (c == ' ') {
                        current_words++;
                    }
                }
            }
            max_words = std::max(max_words, current_words);
        }

        return max_words;
    }
};