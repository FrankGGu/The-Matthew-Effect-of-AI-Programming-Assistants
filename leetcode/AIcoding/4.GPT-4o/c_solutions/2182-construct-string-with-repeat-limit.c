#include <string.h>
#include <stdlib.h>

char *repeatLimitedString(char *s, int repeatLimit) {
    int freq[26] = {0};
    for (int i = 0; s[i]; i++) {
        freq[s[i] - 'a']++;
    }

    char *result = (char *)malloc(strlen(s) + 1);
    int index = 0;

    while (1) {
        int found = 0;
        for (int i = 25; i >= 0; i--) {
            if (freq[i] > 0) {
                if (index >= 2 && result[index - 1] == 'a' + i && result[index - 2] == 'a' + i) {
                    int j;
                    for (j = 25; j >= 0; j--) {
                        if (j != i && freq[j] > 0) {
                            result[index++] = 'a' + j;
                            freq[j]--;
                            break;
                        }
                    }
                    if (j < 0) break;
                }
                result[index++] = 'a' + i;
                freq[i]--;
                found = 1;
                break;
            }
        }
        if (!found) break;
    }
    result[index] = '\0';
    return result;
}