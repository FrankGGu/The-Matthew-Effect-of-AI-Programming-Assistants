#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* longestSubsequenceRepeatedK(char* s, int k) {
    int n = strlen(s);
    char* res = "";
    int maxLen = 0;

    for (int len = 1; len <= n / k; len++) {
        char* temp = (char*)malloc((len + 1) * sizeof(char));
        temp[len] = '\0';

        for (long long mask = (1LL << len) - 1; mask >= 0; mask--) {
            int idx = 0;
            for (int i = len - 1; i >= 0; i--) {
                temp[i] = (mask & (1LL << idx)) ? 'b' : 'a';
                idx++;
            }

            int count = 0;
            int pos = 0;
            for (int i = 0; i < n; i++) {
                if (s[i] == temp[pos]) {
                    pos++;
                    if (pos == len) {
                        count++;
                        pos = 0;
                    }
                }
            }

            if (count >= k) {
                if (len > maxLen) {
                    maxLen = len;
                    if (res != "") free(res);
                    res = (char*)malloc((len + 1) * sizeof(char));
                    strcpy(res, temp);
                }
            }
        }
        free(temp);
    }

    if (res == "") {
        res = (char*)malloc(1 * sizeof(char));
        res[0] = '\0';
    }

    return res;
}