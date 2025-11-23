#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool solve(char** words, int wordsSize, char* result) {
    char chars[26] = {0};
    int charCount = 0;
    bool leading[26] = {false};
    int coefficients[26] = {0};

    for (int i = 0; i < wordsSize; i++) {
        int len = strlen(words[i]);
        leading[words[i][0] - 'A'] = true;
        for (int j = 0; j < len; j++) {
            int c = words[i][j] - 'A';
            coefficients[c] += pow(10, len - j - 1);
            if (chars[c] == 0) {
                chars[c] = 1;
                charCount++;
            }
        }
    }

    int resultLen = strlen(result);
    leading[result[0] - 'A'] = true;
    for (int i = 0; i < resultLen; i++) {
        int c = result[i] - 'A';
        coefficients[c] -= pow(10, resultLen - i - 1);
        if (chars[c] == 0) {
            chars[c] = 1;
            charCount++;
        }
    }

    int assignment[26] = {0};
    bool used[10] = {false};

    int charIndex = 0;
    for (int i = 0; i < 26; i++) {
        if (chars[i] == 1) {
            chars[i] = charIndex++;
        }
    }

    int solveHelper(int index) {
        if (index == charCount) {
            int sum = 0;
            for (int i = 0; i < 26; i++) {
                if (chars[i] != 0) {
                    sum += coefficients[i] * assignment[i];
                }
            }
            return sum == 0;
        }

        for (int i = 0; i < 26; i++) {
            if (chars[i] == index + 1) {
                for (int digit = 0; digit <= 9; digit++) {
                    if (!used[digit]) {
                        if (digit == 0 && leading[i]) continue;
                        assignment[i] = digit;
                        used[digit] = true;
                        if (solveHelper(index + 1)) {
                            return 1;
                        }
                        used[digit] = false;
                        assignment[i] = 0;
                    }
                }
                return 0;
            }
        }
        return 0;
    }

    return solveHelper(0);
}