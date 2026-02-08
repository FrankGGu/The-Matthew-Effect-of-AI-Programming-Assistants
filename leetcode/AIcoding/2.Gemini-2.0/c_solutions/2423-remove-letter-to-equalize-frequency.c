#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool equalFrequency(char * word){
    int freq[26] = {0};
    int len = strlen(word);

    for (int i = 0; i < len; i++) {
        freq[word[i] - 'a']++;
    }

    for (int i = 0; i < len; i++) {
        int temp_freq[26];
        memcpy(temp_freq, freq, sizeof(freq));
        temp_freq[word[i] - 'a']--;

        int count = 0;
        int first_freq = -1;
        bool possible = true;
        for (int j = 0; j < 26; j++) {
            if (temp_freq[j] > 0) {
                if (first_freq == -1) {
                    first_freq = temp_freq[j];
                    count++;
                } else if (temp_freq[j] != first_freq) {
                    possible = false;
                    break;
                } else {
                    count++;
                }
            }
        }

        if (possible && count > 0) {
            return true;
        }
    }

    return false;
}