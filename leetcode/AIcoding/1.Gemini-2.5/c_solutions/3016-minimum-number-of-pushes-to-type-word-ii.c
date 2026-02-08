#include <stdlib.h> // For qsort
#include <string.h> // For strlen

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int minimumPushes(char * word) {
    int freq[26] = {0};
    int len = strlen(word);

    for (int i = 0; i < len; i++) {
        freq[word[i] - 'a']++;
    }

    qsort(freq, 26, sizeof(int), compare);

    int totalPushes = 0;
    int pushMultiplier = 1;
    int charCountOnCurrentPushLevel = 0; // Counts how many characters have been assigned to the current pushMultiplier level

    for (int i = 0; i < 26; i++) {
        if (freq[i] == 0) {
            // All remaining frequencies are zero, no more characters to assign
            break;
        }

        totalPushes += freq[i] * pushMultiplier;
        charCountOnCurrentPushLevel++;

        // After 9 characters have been assigned to the current pushMultiplier level
        // (i.e., one for each of the 9 buttons), we move to the next push level.
        if (charCountOnCurrentPushLevel == 8) {
            pushMultiplier++;
            charCountOnCurrentPushLevel = 0;
        }
    }

    return totalPushes;
}