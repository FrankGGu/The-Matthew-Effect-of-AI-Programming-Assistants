#include <string.h>
#include <stdbool.h>

bool isSubsequence(const char* s, const char* t) {
    int i = 0; // Pointer for s
    int j = 0; // Pointer for t
    while (s[i] != '\0' && t[j] != '\0') {
        if (s[i] == t[j]) {
            j++;
        }
        i++;
    }
    return t[j] == '\0'; // If j reached the end of t, it's a subsequence
}

char* findLongestWord(char* s, char** dictionary, int dictionarySize) {
    char* result = ""; // Initialize with an empty string literal

    for (int i = 0; i < dictionarySize; i++) {
        char* currentWord = dictionary[i];
        if (isSubsequence(s, currentWord)) {
            // Check length
            int currentLen = strlen(currentWord);
            int resultLen = strlen(result);

            if (currentLen > resultLen) {
                result = currentWord;
            } else if (currentLen == resultLen) {
                // If lengths are equal, check lexicographical order
                if (strcmp(currentWord, result) < 0) {
                    result = currentWord;
                }
            }
        }
    }

    return result;
}