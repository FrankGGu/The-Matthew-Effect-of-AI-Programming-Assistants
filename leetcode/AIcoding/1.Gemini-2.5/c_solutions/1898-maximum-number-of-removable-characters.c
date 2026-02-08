#include <string.h>
#include <stdbool.h>
#include <stdlib.h>

bool check(char *s, char *p, int *removable, int k, int s_len, int p_len) {
    bool *removed_indices = (bool *)calloc(s_len, sizeof(bool));

    for (int i = 0; i < k; ++i) {
        removed_indices[removable[i]] = true;
    }

    int s_ptr = 0;
    int p_ptr = 0;

    while (s_ptr < s_len && p_ptr < p_len) {
        if (removed_indices[s_ptr]) {
            s_ptr++;
            continue;
        }

        if (s[s_ptr] == p[p_ptr]) {
            s_ptr++;
            p_ptr++;
        } else {
            p_ptr++;
        }
    }

    free(removed_indices);

    return s_ptr == s_len;
}

int maximumRemovals(char *s, char *p, int *removable, int removableSize) {
    int s_len = strlen(s);
    int p_len = strlen(p);

    int low = 0;
    int high = removableSize;
    int ans = 0;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (check(s, p, removable, mid, s_len, p_len)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
}