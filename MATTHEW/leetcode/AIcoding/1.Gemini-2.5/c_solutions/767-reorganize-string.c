#include <string.h>
#include <stdlib.h>

char* reorganizeString(char* s) {
    int counts[26] = {0};
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        counts[s[i] - 'a']++;
    }

    int maxFreq = 0;
    int maxCharIdx = 0;
    for (int i = 0; i < 26; i++) {
        if (counts[i] > maxFreq) {
            maxFreq = counts[i];
            maxCharIdx = i;
        }
    }

    if (maxFreq > (len + 1) / 2) {
        return "";
    }

    char* result = (char*)malloc(sizeof(char) * (len + 1));
    if (result == NULL) {
        return "";
    }

    int index = 0;

    while (counts[maxCharIdx] > 0) {
        result[index] = (char)('a' + maxCharIdx);
        index += 2;
        counts[maxCharIdx]--;
    }

    for (int i = 0; i < 26; i++) {
        while (counts[i] > 0) {
            if (index >= len) {
                index = 1;
            }
            result[index] = (char)('a' + i);
            index += 2;
            counts[i]--;
        }
    }

    result[len] = '\0';
    return result;
}