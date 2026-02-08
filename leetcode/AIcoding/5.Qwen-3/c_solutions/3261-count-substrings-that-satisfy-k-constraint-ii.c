#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countKConstraintSubstrings(char* s, int k) {
    int n = strlen(s);
    int count = 0;
    for (int i = 0; i < n; i++) {
        int zeroCount = 0;
        int oneCount = 0;
        for (int j = i; j < n; j++) {
            if (s[j] == '0') zeroCount++;
            else oneCount++;
            if (zeroCount <= k && oneCount <= k) count++;
        }
    }
    return count;
}