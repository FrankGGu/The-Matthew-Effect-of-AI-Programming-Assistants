#include <string.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int findSubstringInWraproundString(char * p){
    int maxLen[26] = {0}; 
    int currentMaxLen = 0;
    int n = strlen(p);

    if (n == 0) {
        return 0;
    }

    for (int i = 0; i < n; i++) {
        if (i > 0 && (p[i] - p[i-1] == 1 || (p[i-1] == 'z' && p[i] == 'a'))) {
            currentMaxLen++;
        } else {
            currentMaxLen = 1;
        }

        maxLen[p[i] - 'a'] = max(maxLen[p[i] - 'a'], currentMaxLen);
    }

    int totalUniqueSubstrings = 0;
    for (int i = 0; i < 26; i++) {
        totalUniqueSubstrings += maxLen[i];
    }

    return totalUniqueSubstrings;
}