#include <stdlib.h>
#include <string.h>

char* convert(char* s, int numRows) {
    int len = strlen(s);

    if (numRows == 1 || len <= numRows) {
        return s;
    }

    char* result = (char*)malloc(sizeof(char) * (len + 1));
    int result_idx = 0;
    int cycleLen = 2 * numRows - 2;

    for (int i = 0; i < numRows; i++) {
        for (int j = i; j < len; j += cycleLen) {
            result[result_idx++] = s[j];

            if (i > 0 && i < numRows - 1) {
                int second_char_idx = j + cycleLen - 2 * i;
                if (second_char_idx < len) {
                    result[result_idx++] = s[second_char_idx];
                }
            }
        }
    }

    result[result_idx] = '\0';
    return result;
}