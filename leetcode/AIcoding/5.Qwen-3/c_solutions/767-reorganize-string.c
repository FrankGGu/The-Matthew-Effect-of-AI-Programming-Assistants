#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char ch;
    int count;
} CharCount;

int compare(const void *a, const void *b) {
    return ((CharCount *)b)->count - ((CharCount *)a)->count;
}

char* reorganizeString(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    if (!result) return NULL;

    int freq[26] = {0};
    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }

    CharCount* chars = (CharCount*)malloc(26 * sizeof(CharCount));
    int count = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            chars[count].ch = 'a' + i;
            chars[count].count = freq[i];
            count++;
        }
    }

    qsort(chars, count, sizeof(CharCount), compare);

    int maxFreq = chars[0].count;
    if (maxFreq > (len + 1) / 2) {
        return "";
    }

    int index = 0;
    for (int i = 0; i < count; i++) {
        while (chars[i].count > 0) {
            result[index] = chars[i].ch;
            index += 2;
            chars[i].count--;
            if (index >= len) {
                index = 1;
            }
        }
    }

    result[len] = '\0';
    free(chars);
    return result;
}