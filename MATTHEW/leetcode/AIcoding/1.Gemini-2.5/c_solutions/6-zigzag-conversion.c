#include <stdlib.h>
#include <string.h>

char* convert(char* s, int numRows) {
    int n = strlen(s);

    if (numRows == 1 || n <= numRows) {
        char* result = (char*)malloc(sizeof(char) * (n + 1));
        strcpy(result, s);
        return result;
    }

    char* result = (char*)malloc(sizeof(char) * (n + 1));
    int resultIdx = 0;
    int cycleLen = 2 * numRows - 2;

    for (int r = 0; r < numRows; r++) {
        for (int j = 0; j + r < n; j += cycleLen) {
            result[resultIdx++] = s[j + r];

            if (r != 0 && r != numRows - 1) {
                int upwardIdx = j + cycleLen - r;
                if (upwardIdx < n) {
                    result[resultIdx++] = s[upwardIdx];
                }
            }
        }
    }

    result[resultIdx] = '\0';
    return result;
}