#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(char* s) {
    int freq[26] = {0};
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        freq[s[i] - 'a']++;
    }

    int max_freq = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > max_freq) {
            max_freq = freq[i];
        }
    }

    int operations = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] != 0 && freq[i] != max_freq) {
            operations += (max_freq - freq[i]);
        }
    }

    return operations;
}