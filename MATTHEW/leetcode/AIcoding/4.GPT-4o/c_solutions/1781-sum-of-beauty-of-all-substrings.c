#include <stdio.h>
#include <string.h>
#include <stdbool.h>

int beautySum(char * s) {
    int totalBeauty = 0;
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        int freq[26] = {0};
        int maxFreq = 0;
        int minFreq = n; 

        for (int j = i; j < n; j++) {
            int index = s[j] - 'a';
            freq[index]++;
            if (freq[index] > maxFreq) {
                maxFreq = freq[index];
            }
            if (freq[index] < minFreq && freq[index] > 0) {
                minFreq = freq[index];
            }
            totalBeauty += maxFreq - minFreq;
        }
    }

    return totalBeauty;
}