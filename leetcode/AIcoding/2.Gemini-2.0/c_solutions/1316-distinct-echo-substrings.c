#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int distinctEchoSubstrings(char * text){
    int n = strlen(text);
    int count = 0;
    bool seen[n * n];
    memset(seen, false, sizeof(seen));
    for (int len = 1; len <= n / 2; len++) {
        for (int i = 0; i <= n - 2 * len; i++) {
            bool match = true;
            for (int j = 0; j < len; j++) {
                if (text[i + j] != text[i + len + j]) {
                    match = false;
                    break;
                }
            }
            if (match) {
                int hash = i * n + len;
                if (!seen[hash]) {
                    count++;
                    seen[hash] = true;
                }
            }
        }
    }
    return count;
}