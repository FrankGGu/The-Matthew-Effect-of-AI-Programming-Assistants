#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findTheLongestBalancedSubstring(char * s){
    int n = strlen(s);
    int max_len = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j <= n; j++) {
            int len = j - i;
            if (len % 2 != 0) continue;
            int zeros = 0;
            int ones = 0;
            for (int k = i; k < j; k++) {
                if (s[k] == '0') {
                    zeros++;
                } else {
                    ones++;
                }
            }
            if (zeros == ones) {
                if (len > max_len) {
                    max_len = len;
                }
            }
        }
    }
    return max_len;
}