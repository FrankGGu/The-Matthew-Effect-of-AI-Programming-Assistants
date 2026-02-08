#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxScoreWords(char **words, int wordsSize, int *letters, int lettersSize, int *score, int scoreSize) {
    int maxScore = 0;

    void backtrack(int index, int currentScore, int *letterCount) {
        if (index == wordsSize) {
            if (currentScore > maxScore) {
                maxScore = currentScore;
            }
            return;
        }

        int canForm = 1;
        int tempCount[26] = {0};
        for (int i = 0; i < strlen(words[index]); i++) {
            tempCount[words[index][i] - 'a']++;
            if (tempCount[words[index][i] - 'a'] > letterCount[words[index][i] - 'a']) {
                canForm = 0;
                break;
            }
        }

        if (canForm) {
            for (int i = 0; i < 26; i++) {
                letterCount[i] -= tempCount[i];
            }
            int scoreForWord = 0;
            for (int i = 0; i < strlen(words[index]); i++) {
                scoreForWord += score[words[index][i] - 'a'];
            }
            backtrack(index + 1, currentScore + scoreForWord, letterCount);
            for (int i = 0; i < 26; i++) {
                letterCount[i] += tempCount[i];
            }
        }

        backtrack(index + 1, currentScore, letterCount);
    }

    int letterCount[26] = {0};
    for (int i = 0; i < lettersSize; i++) {
        letterCount[letters[i] - 'a']++;
    }

    backtrack(0, 0, letterCount);
    return maxScore;
}