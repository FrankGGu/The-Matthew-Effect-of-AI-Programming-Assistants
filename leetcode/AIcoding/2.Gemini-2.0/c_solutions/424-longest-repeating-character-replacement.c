#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int characterReplacement(char * s, int k){
    int len = strlen(s);
    int left = 0, right = 0;
    int max_len = 0;
    int max_count = 0;
    int count[26] = {0};

    while (right < len) {
        count[s[right] - 'A']++;
        max_count = 0;
        for (int i = 0; i < 26; i++) {
            if (count[i] > max_count) {
                max_count = count[i];
            }
        }

        while (right - left + 1 - max_count > k) {
            count[s[left] - 'A']--;
            left++;
            max_count = 0;
            for (int i = 0; i < 26; i++) {
                if (count[i] > max_count) {
                    max_count = count[i];
                }
            }
        }

        if (right - left + 1 > max_len) {
            max_len = right - left + 1;
        }

        right++;
    }

    return max_len;
}