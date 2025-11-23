#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumPalindromes(int* words, int wordsSize) {
    int freq[26] = {0};
    for (int i = 0; i < wordsSize; i++) {
        char* word = (char*)words[i];
        for (int j = 0; j < strlen(word); j++) {
            freq[word[j] - 'a']++;
        }
    }

    int evenCount = 0;
    int oddCount = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] % 2 == 0) {
            evenCount += freq[i] / 2;
        } else {
            evenCount += (freq[i] - 1) / 2;
            oddCount++;
        }
    }

    return evenCount + (oddCount > 0 ? 1 : 0);
}