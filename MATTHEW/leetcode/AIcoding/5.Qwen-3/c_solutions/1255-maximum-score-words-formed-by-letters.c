#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxScoreWords(char** words, int wordsSize, char* letters, int lettersSize) {
    int letterCount[26] = {0};
    for (int i = 0; i < lettersSize; i++) {
        letterCount[letters[i] - 'a']++;
    }

    int wordCount[wordsSize][26];
    for (int i = 0; i < wordsSize; i++) {
        memset(wordCount[i], 0, sizeof(wordCount[i]));
        for (int j = 0; j < strlen(words[i]); j++) {
            wordCount[i][words[i][j] - 'a']++;
        }
    }

    int scores[wordsSize];
    for (int i = 0; i < wordsSize; i++) {
        scores[i] = 0;
        for (int j = 0; j < 26; j++) {
            scores[i] += (j + 1) * wordCount[i][j];
        }
    }

    int maxScore = 0;

    for (int mask = 0; mask < (1 << wordsSize); mask++) {
        int totalScore = 0;
        int tempLetterCount[26];
        memcpy(tempLetterCount, letterCount, sizeof(tempLetterCount));

        for (int i = 0; i < wordsSize; i++) {
            if (mask & (1 << i)) {
                for (int j = 0; j < 26; j++) {
                    if (wordCount[i][j] > tempLetterCount[j]) {
                        break;
                    }
                    tempLetterCount[j] -= wordCount[i][j];
                } else {
                    totalScore += scores[i];
                }
            }
        }

        if (totalScore > maxScore) {
            maxScore = totalScore;
        }
    }

    return maxScore;
}