#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countKFrequency(char* s, int k) {
    int n = strlen(s);
    int count = 0;
    for (int i = 0; i < n; i++) {
        int freq[26] = {0};
        for (int j = i; j < n; j++) {
            freq[s[j] - 'a']++;
            int valid = 1;
            for (int m = 0; m < 26; m++) {
                if (freq[m] != 0 && freq[m] != k) {
                    valid = 0;
                    break;
                }
            }
            if (valid) {
                count++;
            }
        }
    }
    return count;
}