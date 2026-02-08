#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countHomogenous(char* s) {
    int n = strlen(s);
    long long count = 0;
    long long mod = 1000000007;
    for (int i = 0; i < n; ) {
        char c = s[i];
        int j = i;
        while (j < n && s[j] == c) {
            j++;
        }
        long long len = j - i;
        count = (count + len * (len + 1) / 2) % mod;
        i = j;
    }
    return (int)count;
}