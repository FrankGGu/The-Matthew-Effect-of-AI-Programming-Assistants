#include <string.h>

long long separateBlackAndWhiteBalls(char* s) {
    long long total_swaps = 0;
    long long ones_count = 0;
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        if (s[i] == '1') {
            ones_count++;
        } else { // s[i] == '0'
            total_swaps += ones_count;
        }
    }

    return total_swaps;
}