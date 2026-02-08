#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSteps(char * s, char * t){
    int s_freq[26] = {0};
    int t_freq[26] = {0};

    for (int i = 0; s[i] != '\0'; i++) {
        s_freq[s[i] - 'a']++;
    }

    for (int i = 0; t[i] != '\0'; i++) {
        t_freq[t[i] - 'a']++;
    }

    int steps = 0;
    for (int i = 0; i < 26; i++) {
        if (s_freq[i] > t_freq[i]) {
            steps += (s_freq[i] - t_freq[i]);
        }
    }

    return steps;
}