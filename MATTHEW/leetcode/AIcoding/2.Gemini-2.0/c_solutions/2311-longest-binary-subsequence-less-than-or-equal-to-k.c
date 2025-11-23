#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestSubsequence(char * s, int k){
    int len = strlen(s);
    int count = 0;
    int num = 0;
    for (int i = len - 1, j = 0; i >= 0; i--, j++) {
        if (s[i] == '0') {
            count++;
        } else {
            if (num + (1 << j) <= k) {
                num += (1 << j);
                count++;
            }
        }
    }
    return count;
}