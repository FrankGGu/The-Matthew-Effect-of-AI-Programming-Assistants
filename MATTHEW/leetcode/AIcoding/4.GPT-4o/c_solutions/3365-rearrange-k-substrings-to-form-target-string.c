#include <stdio.h>
#include <string.h>
#include <stdbool.h>

bool canArrange(char* S, char* target, int K) {
    int lenS = strlen(S);
    int lenT = strlen(target);

    if (lenS < lenT || lenS % K != 0) return false;

    int countS[26] = {0};
    int countT[26] = {0};

    for (int i = 0; i < lenS; i++) {
        countS[S[i] - 'a']++;
    }
    for (int i = 0; i < lenT; i++) {
        countT[target[i] - 'a']++;
    }

    for (int i = 0; i < 26; i++) {
        if (countS[i] < countT[i] || (countS[i] - countT[i]) % K != 0) {
            return false;
        }
    }

    return true;
}

bool rearrangeKSubstrings(char* S, int K, char* target) {
    return canArrange(S, target, K);
}