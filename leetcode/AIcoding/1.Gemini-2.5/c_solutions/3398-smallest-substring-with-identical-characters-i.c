#include <string.h>
#include <limits.h>

int smallestSubstringWithIdenticalCharacters(char * s) {
    int n = strlen(s);
    if (n == 0) {
        return 0;
    }

    int min_len = INT_MAX;
    int i = 0;
    while (i < n) {
        char current_char = s[i];
        int current_run_len = 0;
        int j = i;
        while (j < n && s[j] == current_char) {
            current_run_len++;
            j++;
        }
        if (current_run_len < min_len) {
            min_len = current_run_len;
        }
        i = j;
    }

    return min_len;
}