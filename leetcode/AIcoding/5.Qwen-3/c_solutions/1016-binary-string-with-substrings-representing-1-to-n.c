#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool hasAllCodesToReachN(char* s, int n) {
    int len = strlen(s);
    if (len < 16) return false;
    int required = n;
    int mask = (1 << 16) - 1;
    int seen = 0;
    int count = 0;
    for (int i = 0; i < len; i++) {
        seen = ((seen << 1) | (s[i] - '0')) & mask;
        if (seen > 0 && seen <= n) {
            count++;
            if (count == required) return true;
        }
    }
    return false;
}