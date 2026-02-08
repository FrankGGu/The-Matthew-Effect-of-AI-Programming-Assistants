#include <string.h>
#include <stdlib.h>

int findFirstAlmostEqualSubstring(char* s, char* target, int k) {
    int n = strlen(s);
    int m = strlen(target);

    if (m == 0) {
        return 0;
    }

    if (n < m) {
        return -1;
    }

    for (int i = 0; i <= n - m; ++i) {
        int is_almost_equal = 1;
        for (int j = 0; j < m; ++j) {
            if (abs(s[i+j] - target[j]) > k) {
                is_almost_equal = 0;
                break;
            }
        }

        if (is_almost_equal) {
            return i;
        }
    }

    return -1;
}