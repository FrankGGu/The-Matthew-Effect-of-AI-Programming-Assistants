#include <string.h>
#include <stdlib.h>

long long minimumOperations(char *s1, char *s2, char *s3) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);
    int len3 = strlen(s3);

    int min_len = len1;
    if (len2 < min_len) {
        min_len = len2;
    }
    if (len3 < min_len) {
        min_len = len3;
    }

    int lcp_len = 0;
    for (int k = min_len; k >= 0; --k) {
        int current_prefix_match = 1;
        for (int i = 0; i < k; ++i) {
            if (s1[i] != s2[i] || s1[i] != s3[i]) {
                current_prefix_match = 0;
                break;
            }
        }

        if (current_prefix_match) {
            lcp_len = k;
            break;
        }
    }

    long long ops = (long long)(len1 - lcp_len) + (long long)(len2 - lcp_len) + (long long)(len3 - lcp_len);
    return ops;
}