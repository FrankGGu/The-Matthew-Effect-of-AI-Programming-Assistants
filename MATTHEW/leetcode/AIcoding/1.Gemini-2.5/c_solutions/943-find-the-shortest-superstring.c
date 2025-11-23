#include <string.h>
#include <stdlib.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int calculate_overlap(const char* s1, const char* s2) {
    int n1 = strlen(s1);
    int n2 = strlen(s2);
    int max_overlap = 0;
    for (int len = min(n1, n2); len >= 1; --len) {
        if (strncmp(s1 + n1 - len, s2, len) == 0) {
            max_overlap = len;
            break;
        }
    }
    return max_overlap;
}

char* shortestSuperstring(char** words, int wordsSize) {
    if (wordsSize == 0) {
        return strdup("");
    }
    if (wordsSize == 1) {
        return strdup(words[0]);
    }

    int overlaps[wordsSize][wordsSize];
    for (int i = 0; i < wordsSize; ++i) {
        for (int j = 0; j < wordsSize; ++j) {
            if (i == j) {
                overlaps[i][j] = 0;
            } else {
                overlaps[i][j] = calculate_overlap(words[i], words[j]);
            }
        }
    }

    int dp[1 << wordsSize][wordsSize];
    int parent[1 << wordsSize][wordsSize];

    for (int i = 0; i < (1 << wordsSize); ++i) {
        for (int j = 0; j < wordsSize; ++j) {
            dp[i][j] = 1000000000;
            parent[i][j] = -1;
        }
    }

    for (int i = 0; i < wordsSize; ++i) {
        dp[1 << i][i] = strlen(words[i]);
    }

    for (int mask = 1; mask < (1 << wordsSize); ++mask) {
        for (int i = 0; i < wordsSize; ++i) {
            if (!((mask >> i) & 1)) continue;

            int prev_mask = mask ^ (1 << i);

            for (int j = 0; j < wordsSize; ++j) {
                if (!((prev_mask >> j) & 1)) continue;

                int current_len = dp[prev_mask][j] + strlen(words[i]) - overlaps[j][i];
                if (current_len < dp[mask][i]) {
                    dp[mask][i] = current_len;
                    parent[mask][i] = j;
                }
            }
        }
    }

    int final_mask = (1 << wordsSize) - 1;
    int min_len = 1000000000;
    int last_word_idx = -1;

    for (int i = 0; i < wordsSize; ++i) {
        if (dp[final_mask][i] < min_len) {
            min_len = dp[final_mask][i];
            last_word_idx = i;
        }
    }

    int path[wordsSize];
    int current_mask = final_mask;
    for (int k = wordsSize - 1; k >= 0; --k) {
        path[k] = last_word_idx;
        int prev_word_idx = parent[current_mask][last_word_idx];
        current_mask ^= (1 << last_word_idx);
        last_word_idx = prev_word_idx;
    }

    char* result = (char*)malloc(min_len + 1);
    if (result == NULL) {
        return NULL; 
    }
    result[0] = '\0';

    strcat(result, words[path[0]]);

    for (int k = 1; k < wordsSize; ++k) {
        int prev_idx = path[k-1];
        int curr_idx = path[k];
        int overlap_len = overlaps[prev_idx][curr_idx];
        strcat(result, words[curr_idx] + overlap_len);
    }

    return result;
}