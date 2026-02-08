#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool matchReplacement(char *s, char *sub, char **mappings, int mappingsSize) {
    int n = strlen(s);
    int m = strlen(sub);

    for (int i = 0; i <= n - m; i++) {
        bool match = true;
        for (int j = 0; j < m; j++) {
            bool found = false;
            if (s[i + j] == sub[j]) {
                found = true;
            } else {
                for (int k = 0; k < mappingsSize; k++) {
                    if (mappings[k][0] == sub[j] && mappings[k][1] == s[i + j]) {
                        found = true;
                        break;
                    }
                }
            }
            if (!found) {
                match = false;
                break;
            }
        }
        if (match) {
            return true;
        }
    }

    return false;
}