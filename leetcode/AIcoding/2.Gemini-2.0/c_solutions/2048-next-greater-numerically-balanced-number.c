#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isBalanced(int n) {
    char s[11];
    sprintf(s, "%d", n);
    int len = strlen(s);
    int counts[10] = {0};
    for (int i = 0; i < len; i++) {
        counts[s[i] - '0']++;
    }

    for (int i = 0; i < 10; i++) {
        if (counts[i] > 0 && counts[i] != i) {
            return false;
        }
    }
    return true;
}

int nextGreaterElement(int n) {
    n++;
    while (!isBalanced(n)) {
        n++;
    }
    return n;
}