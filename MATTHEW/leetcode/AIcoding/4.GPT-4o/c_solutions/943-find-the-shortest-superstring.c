#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAXN 12
#define MAXLEN 1000

int n;
char* strs[MAXN];
int overlap[MAXN][MAXN];

int max(int a, int b) {
    return a > b ? a : b;
}

int calcOverlap(char* a, char* b) {
    int lenA = strlen(a);
    int lenB = strlen(b);
    int maxOverlap = 0;
    for (int i = 1; i <= lenA; i++) {
        if (strncmp(a + lenA - i, b, i) == 0) {
            maxOverlap = i;
        }
    }
    return maxOverlap;
}

void buildOverlap() {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (i != j) {
                overlap[i][j] = calcOverlap(strs[i], strs[j]);
            }
        }
    }
}

int dp[1 << MAXN][MAXN];
int parent[1 << MAXN][MAXN];

int findShortestSuperstring() {
    int fullMask = (1 << n) - 1;
    for (int mask = 0; mask < (1 << n); mask++) {
        for (int i = 0; i < n; i++) {
            dp[mask][i] = MAXLEN * MAXN;
            parent[mask][i] = -1;
        }
    }

    for (int i = 0; i < n; i++) {
        dp[1 << i][i] = strlen(strs[i]);
    }

    for (int mask = 0; mask < (1 << n); mask++) {
        for (int i = 0; i < n; i++) {
            if (mask & (1 << i)) {
                for (int j = 0; j < n; j++) {
                    if (!(mask & (1 << j))) {
                        int newMask = mask | (1 << j);
                        int newLength = dp[mask][i] + strlen(strs[j]) - overlap[i][j];
                        if (newLength < dp[newMask][j]) {
                            dp[newMask][j] = newLength;
                            parent[newMask][j] = i;
                        }
                    }
                }
            }
        }
    }

    int minLength = MAXLEN * MAXN;
    int lastIdx = -1;

    for (int i = 0; i < n; i++) {
        if (dp[fullMask][i] < minLength) {
            minLength = dp[fullMask][i];
            lastIdx = i;
        }
    }

    char* result = (char*)malloc((minLength + 1) * sizeof(char));
    result[minLength] = '\0';

    int mask = fullMask;
    int idx = lastIdx;
    int pos = minLength;

    while (idx != -1) {
        int prevIdx = parent[mask][idx];
        if (prevIdx != -1) {
            int start = pos - strlen(strs[idx]) + overlap[prevIdx][idx];
            memcpy(result + start, strs[idx], strlen(strs[idx]));
            pos = start;
        } else {
            memcpy(result, strs[idx], strlen(strs[idx]));
            pos = strlen(strs[idx]);
        }
        mask ^= (1 << idx);
        idx = prevIdx;
    }

    return result;
}

char* shortestSuperstring(char** words, int wordsSize) {
    n = wordsSize;
    for (int i = 0; i < n; i++) {
        strs[i] = words[i];
    }
    buildOverlap();
    return findShortestSuperstring();
}