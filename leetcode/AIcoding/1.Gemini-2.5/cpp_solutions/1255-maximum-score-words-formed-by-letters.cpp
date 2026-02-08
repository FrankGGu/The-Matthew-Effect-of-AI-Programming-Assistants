#include <iostream>
#include <vector>
#include <string>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int maxScoreWords(std::vector<std::string>& words, std::vector<char>& letters, std::vector<int>& score) {
        std::vector<int> letterCount(26, 0);
        for (char c : letters) {
            letterCount[c - 'a']++;
        }
        return backtrack(0, words, score, letterCount);
    }

private:
    int backtrack(int index, const std::vector<std::string>& words, const std::vector<int>& score, std::vector<int>& letterCount) {
        if (index == words.size()) {
            return 0;
        }

        int scoreSkip = backtrack(index + 1, words, score, letterCount);

        int scoreTake = 0;
        int currentWordScore = 0;
        bool canForm = true;
        std::vector<int> wordFreq(26, 0);

        for (char c : words[index]) {
            wordFreq[c - 'a']++;
        }

        for (int i = 0; i < 26; ++i) {
            if (wordFreq[i] > letterCount[i]) {
                canForm = false;
                break;
            }
        }

        if (canForm) {
            for (int i = 0; i < 26; ++i) {
                if (wordFreq[i] > 0) {
                    letterCount[i] -= wordFreq[i];
                    currentWordScore += wordFreq[i] * score[i];
                }
            }

            scoreTake = currentWordScore + backtrack(index + 1, words, score, letterCount);

            for (int i = 0; i < 26; ++i) {
                if (wordFreq[i] > 0) {
                    letterCount[i] += wordFreq[i];
                }
            }
        }

        return std::max(scoreSkip, scoreTake);
    }
};