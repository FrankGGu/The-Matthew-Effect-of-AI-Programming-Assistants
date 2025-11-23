#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int uniqueLetterString(char * s){
    int n = strlen(s);
    int left[n], right[n];
    int lastPos[26];
    memset(lastPos, -1, sizeof(lastPos));
    for (int i = 0; i < n; i++) {
        int c = s[i] - 'A';
        if (lastPos[c] == -1) {
            left[i] = i + 1;
        } else {
            left[i] = i - lastPos[c];
        }
        lastPos[c] = i;
    }
    memset(lastPos, -1, sizeof(lastPos));
    for (int i = n - 1; i >= 0; i--) {
        int c = s[i] - 'A';
        if (lastPos[c] == -1) {
            right[i] = n - i;
        } else {
            right[i] = lastPos[c] - i;
        }
        lastPos[c] = i;
    }
    long long ans = 0;
    for (int i = 0; i < n; i++) {
        ans += (long long)left[i] * right[i];
    }
    return ans % 1000000007;
}