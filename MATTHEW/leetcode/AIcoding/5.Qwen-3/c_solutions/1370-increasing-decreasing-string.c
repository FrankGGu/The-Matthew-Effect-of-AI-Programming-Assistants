#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* sortString(char* s) {
    int count[26] = {0};
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        count[s[i] - 'a']++;
    }

    char* result = (char*)malloc((len + 1) * sizeof(char));
    int index = 0;

    while (index < len) {
        for (int i = 0; i < 26 && index < len; i++) {
            if (count[i] > 0) {
                result[index++] = i + 'a';
                count[i]--;
            }
        }
        for (int i = 25; i >= 0 && index < len; i--) {
            if (count[i] > 0) {
                result[index++] = i + 'a';
                count[i]--;
            }
        }
    }

    result[len] = '\0';
    return result;
}