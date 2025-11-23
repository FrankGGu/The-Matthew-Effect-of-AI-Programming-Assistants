#define CHAR_COUNT 26

int isUnique(int *arr, int size) {
    int seen[CHAR_COUNT] = {0};
    for (int i = 0; i < size; i++) {
        if (arr[i] >= 0 && arr[i] < CHAR_COUNT) {
            if (seen[arr[i]]) return 0;
            seen[arr[i]] = 1;
        }
    }
    return 1;
}

int eval(int *digits, int *len, int numWords, int *sumLen, int *result) {
    int total = 0;
    for (int i = 0; i < numWords; i++) {
        int wordValue = 0;
        for (int j = 0; j < len[i]; j++) {
            wordValue = wordValue * 10 + digits[result[i * 10 + j]];
        }
        total += wordValue;
    }
    return total;
}

int backtrack(int *digits, int *len, int numWords, int *result, int index, int *sumLen, int expectedSum) {
    if (index == numWords) {
        int total = eval(digits, len, numWords, sumLen, result);
        return total == expectedSum;
    }

    for (int i = 0; i < 10; i++) {
        result[index * 10] = i;
        if (isUnique(result, (index + 1) * 10) && backtrack(digits, len, numWords, result, index + 1, sumLen, expectedSum)) {
            return 1;
        }
    }
    return 0;
}

bool isSolvable(char **words, int wordsSize, char *resultWord) {
    int len[wordsSize];
    int sumLen = strlen(resultWord);
    for (int i = 0; i < wordsSize; i++) {
        len[i] = strlen(words[i]);
    }

    int digits[CHAR_COUNT] = {0};
    int result[wordsSize * 10] = {0};
    for (int i = 0; i < CHAR_COUNT; i++) {
        digits[i] = -1;
    }

    int total = 0;
    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; j < len[i]; j++) {
            if (digits[words[i][j] - 'a'] == -1) {
                digits[words[i][j] - 'a'] = 0;
            }
        }
    }

    for (int i = 0; i < sumLen; i++) {
        if (digits[resultWord[i] - 'a'] == -1) {
            digits[resultWord[i] - 'a'] = 0;
        }
    }

    return backtrack(digits, len, wordsSize, result, 0, &sumLen, total);
}