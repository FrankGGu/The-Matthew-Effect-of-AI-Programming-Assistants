#include <string.h>
#include <stdbool.h>

char* smallestBeautifulString(char* s, int k) {
    int n = strlen(s);
    char* result = (char*)malloc((n + 1) * sizeof(char));
    strcpy(result, s);

    for (int i = n - 1; i >= 0; i--) {
        if (result[i] < 'a' + k - 1) {
            result[i]++;
            for (int j = i + 1; j < n; j++) {
                result[j] = 'a';
            }
            bool valid = true;
            for (int j = 0; j < n - 1; j++) {
                if (result[j] == result[j + 1] || (j > 0 && result[j] == result[j - 1] + 1)) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                return result;
            }
        }
    }

    free(result);
    return "";
}