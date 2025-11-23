#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubstrings(char * s, int k){
    int n = strlen(s);
    int count = 0;

    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            int freq[26] = {0};
            for (int l = i; l <= j; l++) {
                freq[s[l] - 'a']++;
            }

            for (int l = 0; l < 26; l++) {
                if (freq[l] == k) {
                    count++;
                    break;
                }
            }
        }
    }

    return count;
}