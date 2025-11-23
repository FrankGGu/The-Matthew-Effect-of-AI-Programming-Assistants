#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxVowels(char * s, int k){
    int n = strlen(s);
    int count = 0;
    for (int i = 0; i < k; i++) {
        if (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u') {
            count++;
        }
    }
    int maxCount = count;
    for (int i = k; i < n; i++) {
        if (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u') {
            count++;
        }
        if (s[i - k] == 'a' || s[i - k] == 'e' || s[i - k] == 'i' || s[i - k] == 'o' || s[i - k] == 'u') {
            count--;
        }
        if (count > maxCount) {
            maxCount = count;
        }
    }
    return maxCount;
}