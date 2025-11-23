#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int smallestSubstring(char * s){
    int n = strlen(s);
    int min_len = n;
    for(int i = 0; i < n; i++){
        for(int j = i + 1; j < n; j++){
            if(s[i] == s[j]){
                min_len = fmin(min_len, j - i + 1);
            }
        }
    }
    return min_len == n ? -1 : min_len;
}