#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long maximumSubsequenceCount(char * text, char * pattern){
    long long ans = 0;
    long long count1 = 0;
    long long count2 = 0;
    int len = strlen(text);
    for (int i = 0; i < len; i++) {
        if (text[i] == pattern[1]) {
            ans += count1;
            count2++;
        }
        if (text[i] == pattern[0]) {
            count1++;
        }
    }
    if (pattern[0] == pattern[1]) {
        ans = (count1 * (count1 - 1)) / 2;
    }
    return ans + (count1 > count2 ? count1 : count2);
}