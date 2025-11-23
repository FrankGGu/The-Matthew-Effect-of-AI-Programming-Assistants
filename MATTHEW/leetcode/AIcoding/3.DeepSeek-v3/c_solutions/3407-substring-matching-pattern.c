#include <string.h>
#include <stdbool.h>

bool match(char* s, char* p) {
    int n = strlen(s);
    int m = strlen(p);

    for (int i = 0; i <= n - m; i++) {
        int j;
        for (j = 0; j < m; j++) {
            if (p[j] != '?' && p[j] != s[i + j]) {
                break;
            }
        }
        if (j == m) {
            return true;
        }
    }
    return false;
}