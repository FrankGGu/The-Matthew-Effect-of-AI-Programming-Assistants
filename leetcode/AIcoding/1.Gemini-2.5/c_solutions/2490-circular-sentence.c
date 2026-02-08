#include <string.h>
#include <stdbool.h>

bool isCircularSentence(char * sentence) {
    int n = strlen(sentence);

    if (n == 0) {
        return false;
    }

    // Check condition 2: The last character of the last word is equal to the first character of the first word.
    if (sentence[n - 1] != sentence[0]) {
        return false;
    }

    // Check condition 1: The last character of each word is equal to the first character of the next word.
    // Iterate through the sentence to find spaces, which separate words.
    for (int i = 0; i < n - 1; i++) {
        if (sentence[i] == ' ') {
            // If a space is found at index i, then:
            // sentence[i - 1] is the last character of the current word.
            // sentence[i + 1] is the first character of the next word.
            if (sentence[i - 1] != sentence[i + 1]) {
                return false;
            }
        }
    }

    return true;
}