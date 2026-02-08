#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countCompleteSubstrings(char * word, int k){
    int n = 0;
    while (word[n] != '\0') {
        n++;
    }

    int count = 0;
    for (int len = k; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int freq[26] = {0};
            bool complete = true;
            for (int j = i; j < i + len; j++) {
                freq[word[j] - 'a']++;
            }

            int distinct = 0;
            for (int j = 0; j < 26; j++) {
                if (freq[j] > 0) {
                    distinct++;
                }
            }

            if (len % k != 0 || len / k != distinct) {
                continue;
            }

            for (int j = 0; j < 26; j++) {
                if (freq[j] > 0 && freq[j] != k) {
                    complete = false;
                    break;
                }
            }

            if (complete) {
                count++;
            }
        }
    }

    return count;
}