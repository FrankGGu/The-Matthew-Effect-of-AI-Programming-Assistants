#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * evaluate(char * s, char *** knowledge, int knowledgeSize, int* knowledgeColSize){
    int len = strlen(s);
    char *res = (char *)malloc(sizeof(char) * (3 * len + 1));
    int res_idx = 0;
    int i = 0;
    while (i < len) {
        if (s[i] == '(') {
            i++;
            int start = i;
            while (s[i] != ')') {
                i++;
            }
            char key[i - start + 1];
            strncpy(key, &s[start], i - start);
            key[i - start] = '\0';
            int found = 0;
            for (int j = 0; j < knowledgeSize; j++) {
                if (strcmp(knowledge[j][0], key) == 0) {
                    char *value = knowledge[j][1];
                    int value_len = strlen(value);
                    for (int k = 0; k < value_len; k++) {
                        res[res_idx++] = value[k];
                    }
                    found = 1;
                    break;
                }
            }
            if (!found) {
                res[res_idx++] = '?';
            }
            i++;
        } else {
            res[res_idx++] = s[i++];
        }
    }
    res[res_idx] = '\0';
    return res;
}