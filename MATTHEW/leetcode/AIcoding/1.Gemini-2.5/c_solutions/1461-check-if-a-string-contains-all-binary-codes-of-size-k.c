#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

bool hasAllCodes(char * s, int k) {
    int n = strlen(s);

    if (n < k) {
        return false;
    }

    int num_codes = 1 << k;
    bool *seen = (bool *)calloc(num_codes, sizeof(bool));
    if (seen == NULL) {
        return false;
    }

    int current_val = 0;
    int count = 0;
    int mask = num_codes - 1;

    for (int i = 0; i < n; i++) {
        current_val = (current_val << 1) | (s[i] - '0');
        current_val &= mask;

        if (i >= k - 1) {
            if (!seen[current_val]) {
                seen[current_val] = true;
                count++;

                if (count == num_codes) {
                    free(seen);
                    return true;
                }
            }
        }
    }

    free(seen);
    return false;
}