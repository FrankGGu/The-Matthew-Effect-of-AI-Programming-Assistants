#include <string.h>
#include <stdbool.h>
#include <stdlib.h>

int minDeletions(char * s){
    int freq[26] = {0};
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }

    bool* used_freq = (bool*)calloc(len + 1, sizeof(bool));
    if (!used_freq) {
        return -1; 
    }

    int deletions = 0;

    for (int i = 0; i < 26; i++) {
        int current_freq = freq[i];

        while (current_freq > 0 && used_freq[current_freq]) {
            current_freq--;
            deletions++;
        }

        if (current_freq > 0) {
            used_freq[current_freq] = true;
        }
    }

    free(used_freq);
    return deletions;
}