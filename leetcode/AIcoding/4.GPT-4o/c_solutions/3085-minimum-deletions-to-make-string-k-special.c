#include <string.h>
#include <stdlib.h>

int minimumDeletions(char * s, int k) {
    int freq[26] = {0};
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        freq[s[i] - 'a']++;
    }

    qsort(freq, 26, sizeof(int), (int (*)(const void *, const void *))strcmp);

    int deletions = 0;
    for (int i = 25; i >= 26 - k; i--) {
        if (i < 0 || freq[i] == 0) break;
        deletions += freq[i] - 1;
    }

    return deletions;
}