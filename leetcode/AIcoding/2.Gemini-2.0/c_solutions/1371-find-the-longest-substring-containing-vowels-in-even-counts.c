#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findTheLongestSubstring(char * s){
    int n = strlen(s);
    int state = 0;
    int first[32];
    for (int i = 0; i < 32; i++) {
        first[i] = -1;
    }
    first[0] = 0;
    int ans = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == 'a') state ^= 1;
        else if (s[i] == 'e') state ^= 2;
        else if (s[i] == 'i') state ^= 4;
        else if (s[i] == 'o') state ^= 8;
        else if (s[i] == 'u') state ^= 16;
        if (first[state] == -1) {
            first[state] = i + 1;
        } else {
            ans = fmax(ans, i + 1 - first[state]);
        }
    }
    return ans;
}