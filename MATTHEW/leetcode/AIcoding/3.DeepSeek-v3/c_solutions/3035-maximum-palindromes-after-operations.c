#include <string.h>

int maxPalindromesAfterOperations(char** words, int wordsSize) {
    int freq[26] = {0};
    int lengths[wordsSize];
    int totalLen = 0;

    for (int i = 0; i < wordsSize; i++) {
        lengths[i] = strlen(words[i]);
        totalLen += lengths[i];
        for (int j = 0; words[i][j]; j++) {
            freq[words[i][j] - 'a']++;
        }
    }

    int pairs = 0;
    for (int i = 0; i < 26; i++) {
        pairs += freq[i] / 2;
    }

    for (int i = 0; i < wordsSize - 1; i++) {
        for (int j = 0; j < wordsSize - i - 1; j++) {
            if (lengths[j] > lengths[j + 1]) {
                int temp = lengths[j];
                lengths[j] = lengths[j + 1];
                lengths[j + 1] = temp;
            }
        }
    }

    int count = 0;
    for (int i = 0; i < wordsSize; i++) {
        int need = lengths[i] / 2;
        if (pairs >= need) {
            pairs -= need;
            count++;
        } else {
            break;
        }
    }

    return count;
}