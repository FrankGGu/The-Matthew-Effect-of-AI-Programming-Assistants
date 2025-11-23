#include <string.h>
#include <stdbool.h>

bool matchReplacement(char *s, char *sub, char **mapping, int mappingSize) {
    int sLen = strlen(s);
    int subLen = strlen(sub);

    for (int i = 0; i <= sLen - subLen; i++) {
        bool match = true;
        for (int j = 0; j < subLen; j++) {
            if (s[i + j] != sub[j]) {
                bool found = false;
                for (int k = 0; k < mappingSize; k++) {
                    if (mapping[k][0] == sub[j] && mapping[k][1] == s[i + j]) {
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    match = false;
                    break;
                }
            }
        }
        if (match) {
            return true;
        }
    }
    return false;
}