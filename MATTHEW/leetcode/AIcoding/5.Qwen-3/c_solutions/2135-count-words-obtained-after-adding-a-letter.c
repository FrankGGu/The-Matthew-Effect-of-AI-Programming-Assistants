#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *word;
    int count;
} WordCount;

int compare(const void *a, const void *b) {
    return strcmp(((WordCount *)a)->word, ((WordCount *)b)->word);
}

int getHash(char *s) {
    int hash = 0;
    for (int i = 0; s[i]; i++) {
        hash += s[i];
    }
    return hash;
}

int countWordsBetweenTwoStrings(char *s1, char *s2) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);
    if (len1 + 1 != len2) return 0;

    int hash1 = getHash(s1);
    int hash2 = getHash(s2);

    int count = 0;
    for (int i = 0; i < len2; i++) {
        char temp[len2];
        strncpy(temp, s2, i);
        strncpy(temp + i, s2 + i + 1, len2 - i - 1);
        temp[len2 - 1] = '\0';
        if (getHash(temp) == hash1) {
            count++;
        }
    }

    return count;
}

int countWords(string *startWords, int startWordsSize, string *targetWords, int targetWordsSize) {
    int result = 0;
    for (int i = 0; i < targetWordsSize; i++) {
        char *target = targetWords[i].str;
        int len = strlen(target);
        int found = 0;
        for (int j = 0; j < startWordsSize; j++) {
            char *start = startWords[j].str;
            int startLen = strlen(start);
            if (startLen + 1 != len) continue;
            int match = 1;
            for (int k = 0; k < len; k++) {
                int foundChar = 0;
                for (int l = 0; l < startLen; l++) {
                    if (target[k] == start[l]) {
                        foundChar = 1;
                        break;
                    }
                }
                if (!foundChar) {
                    match = 0;
                    break;
                }
            }
            if (match) {
                found = 1;
                break;
            }
        }
        if (found) result++;
    }
    return result;
}