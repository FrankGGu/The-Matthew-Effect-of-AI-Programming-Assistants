#include <stdbool.h>
#include <string.h>

int countDistinct(int freq[26]) {
    int distinct_count = 0;
    for (int k = 0; k < 26; k++) {
        if (freq[k] > 0) {
            distinct_count++;
        }
    }
    return distinct_count;
}

bool makeEqual(char * word1, char * word2) {
    int freq1[26] = {0};
    int freq2[26] = {0};

    for (int i = 0; word1[i] != '\0'; i++) {
        freq1[word1[i] - 'a']++;
    }
    for (int i = 0; word2[i] != '\0'; i++) {
        freq2[word2[i] - 'a']++;
    }

    for (int c1_idx = 0; c1_idx < 26; c1_idx++) {
        if (freq1[c1_idx] == 0) {
            continue;
        }

        for (int c2_idx = 0; c2_idx < 26; c2_idx++) {
            if (freq2[c2_idx] == 0) {
                continue;
            }

            freq1[c1_idx]--;
            freq1[c2_idx]++;
            freq2[c2_idx]--;
            freq2[c1_idx]++;

            int current_distinct1 = countDistinct(freq1);
            int current_distinct2 = countDistinct(freq2);

            if (current_distinct1 == current_distinct2) {
                return true;
            }

            freq1[c1_idx]++;
            freq1[c2_idx]--;
            freq2[c2_idx]++;
            freq2[c1_idx]--;
        }
    }

    return false;
}