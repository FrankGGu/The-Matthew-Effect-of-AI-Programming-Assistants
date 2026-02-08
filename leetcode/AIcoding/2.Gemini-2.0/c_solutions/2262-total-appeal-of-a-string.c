#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long appealSum(char * s){
    int n = 0;
    while (s[n] != '\0') {
        n++;
    }
    long long ans = 0;
    long long last[26];
    for (int i = 0; i < 26; i++) {
        last[i] = -1;
    }
    for (int i = 0; i < n; i++) {
        int c = s[i] - 'a';
        ans += (i + 1) * (i - last[c]);
        last[c] = i;
    }
    return ans;
}