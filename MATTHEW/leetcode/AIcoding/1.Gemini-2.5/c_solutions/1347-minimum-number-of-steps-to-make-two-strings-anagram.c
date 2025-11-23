#include <string.h>
#include <stdlib.h>

int minSteps(char * s, char * t){
    int freq_s[26] = {0};
    int freq_t[26] = {0};
    int steps = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        freq_s[s[i] - 'a']++;
    }

    for (int i = 0; t[i] != '\0'; i++) {
        freq_t[t[i] - 'a']++;
    }

    for (int i = 0; i < 26; i++) {
        if (freq_s[i] > freq_t[i]) {
            steps += (freq_s[i] - freq_t[i]);
        }
    }

    return steps;
}