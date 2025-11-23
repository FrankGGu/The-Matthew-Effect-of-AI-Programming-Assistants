#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *repeatLimitedString(char *s, int repeatLimit) {
    int counts[26] = {0};
    for (int i = 0; s[i] != '\0'; i++) {
        counts[s[i] - 'a']++;
    }

    int len = strlen(s);
    char *result = (char *)malloc((len + 1) * sizeof(char));
    result[len] = '\0';
    int index = 0;

    for (int i = 25; i >= 0; i--) {
        while (counts[i] > 0) {
            int repeat = 0;
            while (repeat < repeatLimit && counts[i] > 0) {
                result[index++] = 'a' + i;
                counts[i]--;
                repeat++;
            }

            if (counts[i] > 0) {
                int j = i - 1;
                while (j >= 0 && counts[j] == 0) {
                    j--;
                }

                if (j < 0) {
                    result[index] = '\0';
                    return result;
                }

                result[index++] = 'a' + j;
                counts[j]--;
            }
        }
    }

    result[index] = '\0';
    return result;
}