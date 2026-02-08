#include <string.h>
#include <stdlib.h> // For fmin, though not strictly necessary as we can use an if statement

int longestCommonPrefix(char ** strs, int strsSize) {
    if (strsSize == 0) {
        return 0;
    }
    if (strsSize == 1) {
        return strlen(strs[0]);
    }

    int prefixLength = strlen(strs[0]);

    for (int i = 1; i < strsSize; i++) {
        int currentCommonLength = 0;
        while (currentCommonLength < prefixLength &&
               strs[0][currentCommonLength] != '\0' &&
               strs[i][currentCommonLength] != '\0' &&
               strs[0][currentCommonLength] == strs[i][currentCommonLength]) {
            currentCommonLength++;
        }
        prefixLength = currentCommonLength;
        if (prefixLength == 0) {
            return 0;
        }
    }

    return prefixLength;
}