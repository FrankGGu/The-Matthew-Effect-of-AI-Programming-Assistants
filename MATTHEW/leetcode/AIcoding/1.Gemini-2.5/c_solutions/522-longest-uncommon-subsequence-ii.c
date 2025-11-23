#include <string.h>
#include <stdbool.h>

bool isSubsequence(char* s1, char* s2) {
    int i = 0, j = 0;
    int len1 = strlen(s1);
    int len2 = strlen(s2);

    while (i < len1 && j < len2) {
        if (s1[i] == s2[j]) {
            i++;
        }
        j++;
    }
    return i == len1;
}

int findLUSlength(char ** strs, int strsSize) {
    int maxLength = -1;

    for (int i = 0; i < strsSize; i++) {
        bool isUncommon = true;
        for (int j = 0; j < strsSize; j++) {
            if (i == j) {
                continue;
            }
            if (isSubsequence(strs[i], strs[j])) {
                isUncommon = false;
                break;
            }
        }

        if (isUncommon) {
            int currentLength = strlen(strs[i]);
            if (currentLength > maxLength) {
                maxLength = currentLength;
            }
        }
    }

    return maxLength;
}