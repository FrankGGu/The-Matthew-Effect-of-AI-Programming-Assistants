#include <stdlib.h>
#include <string.h>

static int compareCounts(int* counts1, int* counts2) {
    for (int i = 0; i < 26; i++) {
        if (counts1[i] != counts2[i]) {
            return 0;
        }
    }
    return 1;
}

int* findAnagrams(char *s, char *p, int* returnSize) {
    *returnSize = 0;
    int s_len = strlen(s);
    int p_len = strlen(p);

    if (s_len < p_len) {
        return (int*)malloc(0);
    }

    int p_counts[26] = {0};
    int s_window_counts[26] = {0};

    for (int i = 0; i < p_len; i++) {
        p_counts[p[i] - 'a']++;
    }

    int capacity = s_len / 2 + 1;
    if (capacity == 0) capacity = 1;
    int* result = (int*)malloc(sizeof(int) * capacity);
    if (result == NULL) {
        return NULL;
    }

    for (int i = 0; i < p_len; i++) {
        s_window_counts[s[i] - 'a']++;
    }

    if (compareCounts(p_counts, s_window_counts)) {
        result[(*returnSize)++] = 0;
    }

    for (int i = p_len; i < s_len; i++) {
        s_window_counts[s[i] - 'a']++;
        s_window_counts[s[i - p_len] - 'a']--;

        if (compareCounts(p_counts, s_window_counts)) {
            if (*returnSize >= capacity) {
                capacity *= 2;
                result = (int*)realloc(result, sizeof(int) * capacity);
                if (result == NULL) {
                    return NULL;
                }
            }
            result[(*returnSize)++] = i - p_len + 1;
        }
    }

    result = (int*)realloc(result, sizeof(int) * (*returnSize));

    return result;
}