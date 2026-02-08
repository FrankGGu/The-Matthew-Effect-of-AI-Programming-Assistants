#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxScoreWords(char ** words, int wordsSize, char * letters, int lettersSize, int* score, int scoreSize){
    int letterCount[26] = {0};
    for (int i = 0; i < lettersSize; i++) {
        letterCount[letters[i] - 'a']++;
    }

    int maxScore = 0;

    function solve = ^(int index, int currentScore, int *currentLetterCount) {
        if (index == wordsSize) {
            if (currentScore > maxScore) {
                maxScore = currentScore;
            }
            return;
        }

        solve(index + 1, currentScore, currentLetterCount); 

        int wordScore = 0;
        int tempLetterCount[26];
        memcpy(tempLetterCount, currentLetterCount, sizeof(int) * 26);
        bool possible = true;
        for (int i = 0; words[index][i] != '\0'; i++) {
            int charIndex = words[index][i] - 'a';
            if (tempLetterCount[charIndex] == 0) {
                possible = false;
                break;
            }
            tempLetterCount[charIndex]--;
            wordScore += score[charIndex];
        }

        if (possible) {
            solve(index + 1, currentScore + wordScore, tempLetterCount);
        }
    };

    solve(0, 0, letterCount);

    return maxScore;
}