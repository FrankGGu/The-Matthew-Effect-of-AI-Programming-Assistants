#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestDecomposition(char * text){
    int n = strlen(text);
    int ans = 0;
    int i = 0, j = n - 1;
    while (i <= j) {
        int len = 1;
        while (i + len - 1 < j - len + 1) {
            int k;
            for (k = 0; k < len; k++) {
                if (text[i + k] != text[j - len + 1 + k]) {
                    break;
                }
            }
            if (k == len) {
                ans += 2;
                i += len;
                j -= len;
                break;
            }
            len++;
        }
        if (i + len - 1 >= j - len + 1) {
            ans++;
            break;
        }
    }
    return ans;
}