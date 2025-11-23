#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkIfPangram(char *sentence) {
    int seen[26] = {0};
    int count = 0;

    for (int i = 0; sentence[i]; i++) {
        char c = sentence[i];
        if (c >= 'a' && c <= 'z') {
            if (!seen[c - 'a']) {
                seen[c - 'a'] = 1;
                count++;
            }
        } else if (c >= 'A' && c <= 'Z') {
            if (!seen[c - 'A']) {
                seen[c - 'A'] = 1;
                count++;
            }
        }
    }

    return count == 26;
}