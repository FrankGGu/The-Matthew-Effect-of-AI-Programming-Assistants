#include <string.h>
#include <stdlib.h>

char *findLexSmallestString(char *s, int a, int b) {
    int n = strlen(s);
    char *ans = (char *)malloc(sizeof(char) * (n + 1));
    strcpy(ans, s);

    char *current_s = (char *)malloc(sizeof(char) * (n + 1));
    char *modified_s = (char *)malloc(sizeof(char) * (n + 1));

    for (int i = 0; i < n; ++i) {
        int rotation_offset = (i * b) % n;
        for (int k_idx = 0; k_idx < n; ++k_idx) {
            current_s[k_idx] = s[(k_idx - rotation_offset + n) % n];
        }
        current_s[n] = '\0';

        for (int j = 0; j < 10; ++j) {
            strcpy(modified_s, current_s);

            for (int k_idx = 1; k_idx < n; k_idx += 2) {
                modified_s[k_idx] = ((modified_s[k_idx] - '0') + (j * a)) % 10 + '0';
            }

            if (strcmp(modified_s, ans) < 0) {
                strcpy(ans, modified_s);
            }
        }
    }

    free(current_s);
    free(modified_s);
    return ans;
}