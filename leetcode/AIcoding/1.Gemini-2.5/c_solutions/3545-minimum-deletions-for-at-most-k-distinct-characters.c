#include <string.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minDeletions(char * s, int k){
    int freq[26] = {0};
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }

    int distinct_freqs[26];
    int distinct_count = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            distinct_freqs[distinct_count++] = freq[i];
        }
    }

    if (distinct_count <= k) {
        return 0;
    }

    qsort(distinct_freqs, distinct_count, sizeof(int), compare);

    int deletions = 0;
    for (int i = 0; i < distinct_count; i++) {
        if (distinct_count > k) {
            deletions += distinct_freqs[i];
            distinct_count--;
        } else {
            break;
        }
    }

    return deletions;
}