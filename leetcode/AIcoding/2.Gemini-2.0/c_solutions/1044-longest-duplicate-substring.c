#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef unsigned long long ull;

ull compute_hash(const char *s, int len) {
    ull h = 0;
    for (int i = 0; i < len; ++i) {
        h = (h * 31) + s[i];
    }
    return h;
}

ull update_hash(ull old_hash, char old_char, char new_char, int len, ull pow31) {
    return (old_hash - old_char * pow31) * 31 + new_char;
}

char* longestDupSubstring(char *s) {
    int n = strlen(s);
    int low = 1, high = n - 1;
    int start = 0, max_len = 0;

    while (low <= high) {
        int len = low + (high - low) / 2;
        ull pow31 = 1;
        for (int i = 0; i < len - 1; ++i) {
            pow31 *= 31;
        }

        ull hash = compute_hash(s, len);

        int found = 0;

        int* seen = (int*)malloc(sizeof(int) * (1 << 20));
        memset(seen, -1, sizeof(int) * (1 << 20));

        int hash_index = hash % (1 << 20);
        seen[hash_index] = 0;

        for (int i = 1; i <= n - len; ++i) {
            hash = update_hash(hash, s[i - 1], s[i + len - 1], len, pow31);
            hash_index = hash % (1 << 20);
            if (seen[hash_index] != -1) {
                int j;
                for (j = 0; j < len; ++j) {
                    if (s[i + j] != s[seen[hash_index] + j]) {
                        break;
                    }
                }
                if (j == len) {
                    start = i;
                    max_len = len;
                    found = 1;
                    break;
                }
            } else {
                seen[hash_index] = i;
            }
        }
        free(seen);

        if (found) {
            low = len + 1;
        } else {
            high = len - 1;
        }
    }

    if (max_len == 0) {
        return "";
    }

    char* result = (char*)malloc(sizeof(char) * (max_len + 1));
    strncpy(result, s + start, max_len);
    result[max_len] = '\0';
    return result;
}