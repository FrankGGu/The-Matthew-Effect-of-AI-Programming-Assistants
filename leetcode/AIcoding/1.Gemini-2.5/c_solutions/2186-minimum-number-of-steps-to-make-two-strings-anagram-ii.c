#include <string.h>
#include <stdlib.h> // For abs

int minSteps(char * s, char * t){
    int freq[26] = {0};
    int steps = 0;

    // Count characters in s
    for (int i = 0; s[i] != '\0'; i++) {
        freq[s[i] - 'a']++;
    }

    // Decrement counts for characters in t
    for (int i = 0; t[i] != '\0'; i++) {
        freq[t[i] - 'a']--;
    }

    // Sum the absolute differences
    for (int i = 0; i < 26; i++) {
        steps += abs(freq[i]);
    }

    return steps;
}