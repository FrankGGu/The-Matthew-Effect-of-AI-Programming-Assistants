#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * smallestBeautifulString(char * s, int k){
    int n = strlen(s);
    for (int i = n - 1; i >= 0; i--) {
        for (char c = s[i] + 1; c < 'a' + k; c++) {
            if ((i > 0 && c == s[i - 1]) || (i > 1 && c == s[i - 2])) {
                continue;
            }
            s[i] = c;
            for (int j = i + 1; j < n; j++) {
                for (char ch = 'a'; ch < 'a' + k; ch++) {
                    if ((j > 0 && ch == s[j - 1]) || (j > 1 && ch == s[j - 2])) {
                        continue;
                    }
                    s[j] = ch;
                    break;
                }
            }
            return s;
        }
    }
    return "";
}