#include <stdio.h>
#include <string.h>

char* smallestBeautifulString(char* s, int n) {
    char* result = (char*)malloc((n + 1) * sizeof(char));
    strcpy(result, s);

    for (int i = n - 1; i >= 0; i--) {
        if (result[i] < 'z') {
            result[i]++;
            for (int j = i + 1; j < n; j++) {
                result[j] = 'a';
            }
            int valid = 1;
            for (int j = 1; j < n; j++) {
                if (result[j] == result[j - 1] || (j > 1 && result[j] == result[j - 2])) {
                    valid = 0;
                    break;
                }
            }
            if (valid) return result;
        }
    }

    free(result);
    return NULL;
}