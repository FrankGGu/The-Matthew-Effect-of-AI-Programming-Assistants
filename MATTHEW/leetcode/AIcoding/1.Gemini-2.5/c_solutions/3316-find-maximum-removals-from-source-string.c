#include <stdbool.h>
#include <string.h>

bool check(char* s, char* p, int* removable, int k, int s_len) {
    bool* is_removed = (bool*)calloc(s_len, sizeof(bool));
    if (is_removed == NULL) {
        // Handle memory allocation failure, though unlikely in LeetCode context
        return false; 
    }

    for (int i = 0; i < k; ++i) {
        is_removed[removable[i]] = true;
    }

    int p_ptr = 0;
    int s_ptr = 0;
    int p_len = strlen(p);

    while (s_ptr < s_len && p_ptr < p_len) {
        if (!is_removed[s_ptr] && s[s_ptr] == p[p_ptr]) {
            p_ptr++;
        }
        s_ptr++;
    }

    free(is_removed);
    return p_ptr == p_len;
}

int maximumRemovals(char* s, char* p, int* removable, int removableSize) {
    int s_len = strlen(s);

    int low = 0;
    int high = removableSize;
    int ans = 0;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (check(s, p, removable, mid, s_len)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
}