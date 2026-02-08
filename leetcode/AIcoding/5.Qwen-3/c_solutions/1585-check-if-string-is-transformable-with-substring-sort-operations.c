#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isTransformable(char* s, char* t) {
    int n = strlen(s);
    if (n != strlen(t)) return false;

    int pos[10][n];
    int cnt[10] = {0};

    for (int i = 0; i < n; i++) {
        pos[s[i] - '0'][cnt[s[i] - '0']++] = i;
    }

    for (int i = 0; i < n; i++) {
        int d = t[i] - '0';
        if (cnt[d] == 0) return false;
        int idx = pos[d][cnt[d] - 1];
        for (int j = 0; j < d; j++) {
            if (cnt[j] > 0 && pos[j][cnt[j] - 1] < idx) return false;
        }
        cnt[d]--;
    }

    return true;
}