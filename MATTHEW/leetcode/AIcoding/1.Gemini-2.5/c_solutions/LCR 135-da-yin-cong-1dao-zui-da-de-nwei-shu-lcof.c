#include <stdlib.h>
#include <string.h>

char *countAndSay(int n) {
    char *prev_str = (char *)malloc(2 * sizeof(char));
    prev_str[0] = '1';
    prev_str[1] = '\0';

    for (int k = 2; k <= n; k++) {
        int prev_len = strlen(prev_str);
        // Max length for n=30 is 132186.
        // The next string can be at most twice the length of the previous string.
        // For n=30, the string for n=29 has length 88052.
        // So the string for n=30 could be up to 2 * 88052 = 176104 characters.
        // Allocate a buffer of 180000 characters for safety (plus null terminator).
        char *current_str = (char *)malloc(180000 * sizeof(char)); 
        int current_idx = 0;

        int i = 0;
        while (i < prev_len) {
            int count = 1;
            int j = i + 1;
            while (j < prev_len && prev_str[j] == prev_str[i]) {
                count++;
                j++;
            }

            current_str[current_idx++] = (char)(count + '0');
            current_str[current_idx++] = prev_str[i];

            i = j;
        }
        current_str[current_idx] = '\0';

        free(prev_str);
        prev_str = current_str;
    }

    return prev_str;
}