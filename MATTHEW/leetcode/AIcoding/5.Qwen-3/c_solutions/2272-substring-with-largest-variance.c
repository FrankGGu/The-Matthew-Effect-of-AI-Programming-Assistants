#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int maxSubstringWithLargestVariance(char* s) {
    int n = strlen(s);
    int max_var = 0;
    for (char c1 = 'a'; c1 <= 'z'; c1++) {
        for (char c2 = 'a'; c2 <= 'z'; c2++) {
            if (c1 == c2) continue;
            int count1 = 0, count2 = 0;
            int has_c2 = 0;
            int var = 0;
            for (int i = 0; i < n; i++) {
                if (s[i] == c1) count1++;
                else if (s[i] == c2) {
                    count2++;
                    has_c2 = 1;
                }
                if (count2 > 0 && count1 > count2) {
                    var = max(var, count1 - count2);
                } else if (count2 > count1) {
                    count1 = 0;
                    count2 = 0;
                }
            }
            if (has_c2) {
                max_var = max(max_var, var);
            }
        }
    }
    return max_var;
}