#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * sortString(char * s){
    int counts[26] = {0};
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        counts[s[i] - 'a']++;
    }

    char *result = (char *)malloc(sizeof(char) * (len + 1));
    int result_index = 0;

    while (result_index < len) {
        for (int i = 0; i < 26; i++) {
            if (counts[i] > 0) {
                result[result_index++] = 'a' + i;
                counts[i]--;
            }
        }
        for (int i = 25; i >= 0; i--) {
            if (counts[i] > 0) {
                result[result_index++] = 'a' + i;
                counts[i]--;
            }
        }
    }

    result[len] = '\0';
    return result;
}