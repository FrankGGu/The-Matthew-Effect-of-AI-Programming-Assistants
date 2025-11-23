#include <string.h>

int findSubstringInWraproundString(char* p) {
    int len = strlen(p);
    if (len == 0) return 0;

    int maxLen[26] = {0};
    int currentLen = 1;

    maxLen[p[0] - 'a'] = 1;

    for (int i = 1; i < len; i++) {
        if ((p[i] - p[i-1] == 1) || (p[i-1] - p[i] == 25)) {
            currentLen++;
        } else {
            currentLen = 1;
        }
        int index = p[i] - 'a';
        if (currentLen > maxLen[index]) {
            maxLen[index] = currentLen;
        }
    }

    int result = 0;
    for (int i = 0; i < 26; i++) {
        result += maxLen[i];
    }

    return result;
}