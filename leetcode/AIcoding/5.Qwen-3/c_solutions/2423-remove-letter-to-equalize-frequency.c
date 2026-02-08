#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char key;
    int count;
} Frequency;

bool equalizeFrequency(char* s) {
    int len = strlen(s);
    Frequency freq[26];
    int freqSize = 0;

    for (int i = 0; i < 26; i++) {
        freq[i].key = 'a' + i;
        freq[i].count = 0;
    }

    for (int i = 0; i < len; i++) {
        for (int j = 0; j < 26; j++) {
            if (s[i] == freq[j].key) {
                freq[j].count++;
                break;
            }
        }
    }

    int counts[26];
    int countSize = 0;

    for (int i = 0; i < 26; i++) {
        if (freq[i].count > 0) {
            counts[countSize++] = freq[i].count;
        }
    }

    for (int i = 0; i < countSize; i++) {
        int temp = counts[i];
        counts[i] = 1;
        int unique = 0;
        for (int j = 0; j < countSize; j++) {
            if (counts[j] == 1) {
                unique++;
            } else {
                if (counts[j] != temp) {
                    unique = -1;
                    break;
                }
            }
        }
        if (unique > 0) {
            return true;
        }
        counts[i] = temp;
    }

    return false;
}