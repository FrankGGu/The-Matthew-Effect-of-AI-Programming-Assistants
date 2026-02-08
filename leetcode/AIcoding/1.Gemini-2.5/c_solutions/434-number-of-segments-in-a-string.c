#include <string.h>

int countSegments(char * s) {
    int count = 0;
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        if (s[i] != ' ' && (i == 0 || s[i-1] == ' ')) {
            count++;
        }
    }
    return count;
}