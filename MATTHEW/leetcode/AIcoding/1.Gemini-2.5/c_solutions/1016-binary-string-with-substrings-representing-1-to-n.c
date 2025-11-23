#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

bool queryString(char * s, int n) {
    int len_s = strlen(s);

    char *found = (char *)calloc(n + 1, sizeof(char));
    if (found == NULL) {
        return false; 
    }

    int count = 0;

    for (int i = 0; i < len_s; i++) {
        long long current_val = 0;

        for (int j = i; j < len_s; j++) {
            current_val = current_val * 2 + (s[j] - '0');

            if (current_val > n) {
                break;
            }

            if (current_val == 0) {
                continue;
            }

            if (!found[current_val]) {
                found[current_val] = 1;
                count++;
            }
        }
    }

    free(found);

    return count == n;
}