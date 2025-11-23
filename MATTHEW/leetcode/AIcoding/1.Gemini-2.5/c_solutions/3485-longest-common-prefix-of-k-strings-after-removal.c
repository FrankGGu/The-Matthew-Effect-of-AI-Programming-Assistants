#include <string.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int longestCommonPrefix(char **strs, int strsSize, int k) {
    int max_lcp = 0;

    for (int i = 0; i < strsSize; i++) {
        char *current_str = strs[i];
        int current_str_len = strlen(current_str);

        for (int prefix_len = 1; prefix_len <= current_str_len; prefix_len++) {
            int count = 0;
            for (int j = 0; j < strsSize; j++) {
                char *other_str = strs[j];
                int other_str_len = strlen(other_str);

                if (other_str_len >= prefix_len && strncmp(current_str, other_str, prefix_len) == 0) {
                    count++;
                }
            }

            if (count >= k) {
                max_lcp = max(max_lcp, prefix_len);
            }
        }
    }

    return max_lcp;
}