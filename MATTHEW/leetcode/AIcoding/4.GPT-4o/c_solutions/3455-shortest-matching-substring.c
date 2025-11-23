#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ALPHABET_SIZE 26

typedef struct {
    char *str;
    int count[ALPHABET_SIZE];
} Counter;

Counter* createCounter(char *s) {
    Counter *counter = malloc(sizeof(Counter));
    counter->str = s;
    memset(counter->count, 0, sizeof(counter->count));
    for (int i = 0; s[i]; i++) {
        counter->count[s[i] - 'a']++;
    }
    return counter;
}

int check(Counter *counter, int *windowCount) {
    for (int i = 0; i < ALPHABET_SIZE; i++) {
        if (counter->count[i] > windowCount[i]) {
            return 0;
        }
    }
    return 1;
}

char *minWindow(char *s, char *t) {
    if (!s || !t || strlen(t) > strlen(s)) return "";

    Counter *tCounter = createCounter(t);
    int windowCount[ALPHABET_SIZE] = {0};
    int left = 0, right = 0, minLen = INT_MAX, start = 0;
    int required = strlen(t);

    while (right < strlen(s)) {
        char rightChar = s[right];
        if (tCounter->count[rightChar - 'a'] > 0) {
            windowCount[rightChar - 'a']++;
            if (windowCount[rightChar - 'a'] <= tCounter->count[rightChar - 'a']) {
                required--;
            }
        }

        while (required == 0) {
            if (minLen > right - left + 1) {
                minLen = right - left + 1;
                start = left;
            }
            char leftChar = s[left];
            if (tCounter->count[leftChar - 'a'] > 0) {
                windowCount[leftChar - 'a']--;
                if (windowCount[leftChar - 'a'] < tCounter->count[leftChar - 'a']) {
                    required++;
                }
            }
            left++;
        }
        right++;
    }

    if (minLen == INT_MAX) return "";

    char *result = (char *)malloc((minLen + 1) * sizeof(char));
    strncpy(result, s + start, minLen);
    result[minLen] = '\0';
    free(tCounter);
    return result;
}