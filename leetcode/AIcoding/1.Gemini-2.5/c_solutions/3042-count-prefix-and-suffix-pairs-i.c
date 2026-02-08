#include <string.h>
#include <stdbool.h>

static bool isPrefixAndSuffix(char* s1, char* s2) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);

    if (len1 > len2) {
        return false;
    }

    // Check if s1 is a prefix of s2
    for (int k = 0; k < len1; k++) {
        if (s1[k] != s2[k]) {
            return false;
        }
    }

    // Check if s1 is a suffix of s2
    for (int k = 0; k < len1; k++) {
        if (s1[k] != s2[len2 - len1 + k]) {
            return false;
        }
    }

    return true;
}

int countPrefixSuffixPairs(char** words, int wordsSize) {
    int count = 0;

    for (int i = 0; i < wordsSize; i++) {
        for (int j = i + 1; j < wordsSize; j++) {
            if (isPrefixAndSuffix(words[i], words[j])) {
                count++;
            }
        }
    }

    return count;
}