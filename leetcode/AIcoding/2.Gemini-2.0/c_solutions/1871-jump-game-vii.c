#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canReach(char * s, int minJump, int maxJump){
    int n = 0;
    while (s[n] != '\0') {
        n++;
    }

    if (s[n - 1] != '0') {
        return false;
    }

    bool *reachable = (bool *)malloc(sizeof(bool) * n);
    for (int i = 0; i < n; i++) {
        reachable[i] = false;
    }

    reachable[0] = true;
    int reachableCount = 0;
    int left = 0;

    for (int i = 0; i < n; i++) {
        if (reachable[i]) {
            for (int j = fmax(i + minJump, left); j <= fmin(i + maxJump, n - 1); j++) {
                if (s[j] == '0' && !reachable[j]) {
                    reachable[j] = true;
                    reachableCount++;
                }
            }
            left = i + maxJump + 1;
        }
    }

    bool result = reachable[n - 1];
    free(reachable);
    return result;
}