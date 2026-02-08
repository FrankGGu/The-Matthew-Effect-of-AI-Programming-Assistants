#include <string.h>
#include <stdlib.h>

int numSplits(char * s){
    int n = strlen(s);

    int *left_distinct = (int *)malloc(n * sizeof(int));
    int *right_distinct = (int *)malloc(n * sizeof(int));

    int freq[26] = {0};
    int distinct_count = 0;

    for (int i = 0; i < n; i++) {
        if (freq[s[i] - 'a'] == 0) {
            distinct_count++;
        }
        freq[s[i] - 'a']++;
        left_distinct[i] = distinct_count;
    }

    for (int i = 0; i < 26; i++) {
        freq[i] = 0;
    }
    distinct_count = 0;

    for (int i = n - 1; i >= 0; i--) {
        if (freq[s[i] - 'a'] == 0) {
            distinct_count++;
        }
        freq[s[i] - 'a']++;
        right_distinct[i] = distinct_count;
    }

    int good_ways_count = 0;
    for (int k = 1; k < n; k++) {
        if (left_distinct[k - 1] == right_distinct[k]) {
            good_ways_count++;
        }
    }

    free(left_distinct);
    free(right_distinct);

    return good_ways_count;
}