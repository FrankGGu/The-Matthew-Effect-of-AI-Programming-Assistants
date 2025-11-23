#include <stdlib.h>
#include <string.h>

char* findTheString(int** lcp, int lcpSize, int* lcpColSize) {
    int n = lcpSize;
    char* res = (char*)malloc((n + 1) * sizeof(char));
    for (int i = 0; i < n; i++) {
        res[i] = '\0';
    }
    res[n] = '\0';

    char cur = 'a';
    for (int i = 0; i < n; i++) {
        if (res[i] == '\0') {
            if (cur > 'z') return "";
            res[i] = cur++;
        }
        for (int j = i + 1; j < n; j++) {
            if (lcp[i][j] > 0) {
                if (res[j] == '\0') {
                    res[j] = res[i];
                } else if (res[j] != res[i]) {
                    return "";
                }
            }
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            int expected;
            if (i == n - 1 || j == n - 1) {
                expected = (res[i] == res[j]) ? 1 : 0;
            } else {
                if (res[i] == res[j]) {
                    expected = lcp[i+1][j+1] + 1;
                } else {
                    expected = 0;
                }
            }
            if (lcp[i][j] != expected) {
                return "";
            }
        }
    }

    return res;
}