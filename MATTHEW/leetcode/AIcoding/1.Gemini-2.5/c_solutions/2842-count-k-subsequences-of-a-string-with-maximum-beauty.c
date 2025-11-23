#include <string.h>
#include <stdlib.h> // For qsort

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

long long combinations(int n, int r) {
    if (r < 0 || r > n) {
        return 0;
    }
    if (r == 0 || r == n) {
        return 1;
    }
    // Optimization: C(n, r) = C(n, n-r)
    if (r > n / 2) {
        r = n - r;
    }
    long long res = 1;
    for (int i = 1; i <= r; ++i) {
        res = res * (n - i + 1) / i;
    }
    return res;
}

long long countKSubsequencesWithMaxBeauty(char * s, int k) {
    int freq[26] = {0};
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }

    int distinct_freqs[26];
    int count_distinct = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            distinct_freqs[count_distinct++] = freq[i];
        }
    }

    if (count_distinct < k) {
        return 0;
    }

    qsort(distinct_freqs, count_distinct, sizeof(int), compare);

    int target_freq = distinct_freqs[k - 1];

    int num_greater = 0; // Number of characters with frequency strictly greater than target_freq
    int num_equal = 0;   // Number of characters with frequency equal to target_freq

    for (int i = 0; i < count_distinct; i++) {
        if (distinct_freqs[i] > target_freq) {
            num_greater++;
        } else if (distinct_freqs[i] == target_freq) {
            num_equal++;
        } else {
            // Since distinct_freqs is sorted descending, all subsequent frequencies will be less than target_freq
            break;
        }
    }

    // We must pick all 'num_greater' characters that have frequencies strictly greater than target_freq.
    // We then need to pick the remaining (k - num_greater) characters from the 'num_equal' characters
    // that have frequency exactly equal to target_freq.
    int to_pick_from_equal = k - num_greater;

    return combinations(num_equal, to_pick_from_equal);
}