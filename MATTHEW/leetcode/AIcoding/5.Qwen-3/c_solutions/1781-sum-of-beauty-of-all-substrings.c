#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumOfBeauty(char* s) {
    int n = strlen(s);
    int result = 0;
    for (int i = 0; i < n; i++) {
        int freq[26] = {0};
        int maxFreq = 0;
        for (int j = i; j < n; j++) {
            int index = s[j] - 'a';
            freq[index]++;
            if (freq[index] > maxFreq) {
                maxFreq = freq[index];
            }
            int beauty = maxFreq - 1;
            result += beauty;
        }
    }
    return result;
}