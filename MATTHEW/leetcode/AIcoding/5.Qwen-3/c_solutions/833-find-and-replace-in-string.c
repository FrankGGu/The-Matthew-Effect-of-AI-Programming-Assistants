#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* findReplaceString(int i, char* s, int* indices, char** sources, char** targets, int n) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int res_idx = 0;
    int idx = 0;

    while (idx < len) {
        int match = -1;
        for (int j = 0; j < n; j++) {
            if (indices[j] == idx) {
                int src_len = strlen(sources[j]);
                if (strncmp(s + idx, sources[j], src_len) == 0) {
                    match = j;
                    break;
                }
            }
        }

        if (match != -1) {
            strcpy(result + res_idx, targets[match]);
            res_idx += strlen(targets[match]);
            idx += strlen(sources[match]);
        } else {
            result[res_idx++] = s[idx++];
        }
    }

    result[res_idx] = '\0';
    return result;
}