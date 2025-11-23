#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int uniqueLetterString(char* s) {
    int n = strlen(s);
    int** pos = (int**)malloc(26 * sizeof(int*));
    for (int i = 0; i < 26; i++) {
        pos[i] = (int*)malloc((n + 2) * sizeof(int));
        pos[i][0] = -1;
    }

    for (int i = 0; i < n; i++) {
        int c = s[i] - 'a';
        pos[c][i + 1] = i;
    }

    for (int i = 0; i < 26; i++) {
        for (int j = 1; j <= n; j++) {
            if (pos[i][j] == 0) {
                pos[i][j] = -1;
            }
        }
    }

    int res = 0;
    for (int i = 0; i < 26; i++) {
        int pre = -1;
        for (int j = 1; j <= n; j++) {
            if (pos[i][j] != -1) {
                int cur = pos[i][j];
                int next = -1;
                for (int k = j + 1; k <= n; k++) {
                    if (pos[i][k] != -1) {
                        next = pos[i][k];
                        break;
                    }
                }
                res += (cur - pre) * (next - cur);
                pre = cur;
            }
        }
    }

    for (int i = 0; i < 26; i++) {
        free(pos[i]);
    }
    free(pos);

    return res;
}