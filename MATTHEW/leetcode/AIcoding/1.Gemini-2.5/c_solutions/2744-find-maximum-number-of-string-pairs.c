#include <string.h>

int maximumNumberOfStringPairs(char **words, int wordsSize) {
    int pairs = 0;

    for (int i = 0; i < wordsSize; i++) {
        for (int j = i + 1; j < wordsSize; j++) {
            char *s1 = words[i];
            char *s2 = words[j];

            // According to the problem constraints, words[i].length is between 1 and 2.
            // A string of length 1 (e.g., "a") can only be its own reverse.
            // Since all strings in 'words' are distinct, a length 1 string cannot be paired
            // with another distinct string to form a reverse pair.
            // Therefore, we only need to consider strings of length 2.
            if (strlen(s1) == 2 && strlen(s2) == 2) {
                // Check if s1 is the reverse of s2.
                // For a length 2 string "xy", its reverse is "yx".
                // So, we check if s1[0] == s2[1] and s1[1] == s2[0].
                if (s1[0] == s2[1] && s1[1] == s2[0]) {
                    pairs++;
                }
            }
        }
    }

    return pairs;
}