#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDeletions(char * s, int k){
    int n = strlen(s);
    int freq[26] = {0};
    for (int i = 0; i < n; i++) {
        freq[s[i] - 'a']++;
    }

    int count = 0;
    int buckets[n + 1];
    memset(buckets, 0, sizeof(buckets));

    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            while (freq[i] > 0 && buckets[freq[i]] > k - 1) {
                freq[i]--;
                count++;
            }
            if (freq[i] > 0) {
                buckets[freq[i]]++;
            }
        }
    }

    return count;
}