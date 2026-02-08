#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * subStrHash(char * s, int power, int modulo, int k, int hashValue){
    int n = strlen(s);
    long long hash = 0;
    long long p = 1;
    int ans_idx = -1;

    for(int i = n - 1; i >= n - k; i++){
        hash = (hash * power + (s[i] - 'a' + 1)) % modulo;
        if(i != n - k)
            p = (p * power) % modulo;
    }

    if(hash == hashValue){
        ans_idx = n - k;
    }

    for(int i = n - k - 1; i >= 0; i--){
        hash = (hash - (long long)(s[i+k] - 'a' + 1) * p % modulo + modulo) % modulo;
        hash = (hash * power + (s[i] - 'a' + 1)) % modulo;

        if(hash == hashValue){
            ans_idx = i;
        }
    }

    char * ans = (char*)malloc(sizeof(char) * (k + 1));
    strncpy(ans, s + ans_idx, k);
    ans[k] = '\0';

    return ans;
}