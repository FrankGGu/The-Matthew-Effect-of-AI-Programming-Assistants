#include <string.h>

int min(int a, int b) {
    return (a < b) ? a : b;
}

int minimumDeletions(char * s, int k) {
    int counts[26] = {0};
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        counts[s[i] - 'a']++;
    }

    int min_deletions = n; 

    for (int target_f = 0; target_f <= k; target_f++) {
        int current_deletions = 0;
        for (int i = 0; i < 26; i++) {
            if (counts[i] == 0) {
                continue;
            }

            if (counts[i] == target_f) {
                continue;
            } else if (counts[i] > target_f) {
                current_deletions += (counts[i] - target_f);
            } else { // counts[i] < target_f
                current_deletions += counts[i];
            }
        }
        min_deletions = min(min_deletions, current_deletions);
    }

    return min_deletions;
}