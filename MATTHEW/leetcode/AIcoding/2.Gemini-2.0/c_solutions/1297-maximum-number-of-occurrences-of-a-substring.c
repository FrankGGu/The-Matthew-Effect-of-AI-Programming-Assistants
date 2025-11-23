#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxFreq(char * s, int maxLetters, int minSize, int maxSize){
    int len = strlen(s);
    int max_freq = 0;
    int* freq = (int*)calloc(26, sizeof(int));

    for (int i = 0; i <= len - minSize; i++) {
        for (int j = minSize; j <= maxSize && i + j <= len; j++) {
            char* sub = (char*)malloc((j + 1) * sizeof(char));
            strncpy(sub, s + i, j);
            sub[j] = '\0';

            int unique_chars = 0;
            int char_count[26] = {0};
            for(int k = 0; k < j; k++) {
                if(char_count[sub[k] - 'a'] == 0) {
                    unique_chars++;
                }
                char_count[sub[k] - 'a']++;
            }

            if (unique_chars <= maxLetters) {
                int count = 0;
                for (int k = 0; k <= len - j; k++) {
                    if (strncmp(s + k, sub, j) == 0) {
                        count++;
                    }
                }
                if (count > max_freq) {
                    max_freq = count;
                }
            }
            free(sub);
        }
    }
    free(freq);
    return max_freq;
}