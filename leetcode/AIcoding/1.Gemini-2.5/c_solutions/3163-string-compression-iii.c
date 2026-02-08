#include <stdlib.h>
#include <string.h>

char* compressString(char* s) {
    int n = strlen(s);
    char* result = (char*)malloc(2 * n + 1); 
    if (result == NULL) {
        return NULL;
    }

    int write_idx = 0;
    int i = 0;
    while (i < n) {
        char current_char = s[i];
        int count = 0;
        int j = i;
        while (j < n && s[j] == current_char) {
            count++;
            j++;
        }

        i = j;

        while (count > 0) {
            if (count >= 10) {
                result[write_idx++] = '9';
                result[write_idx++] = current_char;
                count -= 9;
            } else if (count >= 2) {
                result[write_idx++] = (char)('0' + count);
                result[write_idx++] = current_char;
                count = 0;
            } else {
                result[write_idx++] = current_char;
                count = 0;
            }
        }
    }
    result[write_idx] = '\0';
    return result;
}