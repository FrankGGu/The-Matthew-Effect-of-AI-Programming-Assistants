#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * customSortString(char * order, char * s){
    int order_map[26] = {0};
    for (int i = 0; order[i] != '\0'; i++) {
        order_map[order[i] - 'a'] = i + 1;
    }

    int s_len = strlen(s);
    char *result = (char *)malloc(sizeof(char) * (s_len + 1));
    strcpy(result, s);

    for (int i = 0; i < s_len - 1; i++) {
        for (int j = 0; j < s_len - i - 1; j++) {
            int char1 = result[j] - 'a';
            int char2 = result[j + 1] - 'a';
            if (order_map[char1] == 0 && order_map[char2] != 0) {
                continue;
            }
            if (order_map[char1] != 0 && order_map[char2] == 0) {
                 char temp = result[j];
                result[j] = result[j + 1];
                result[j + 1] = temp;
                continue;
            }
            if (order_map[char1] == 0 && order_map[char2] == 0) {
                if (result[j] > result[j+1]) {
                     char temp = result[j];
                    result[j] = result[j + 1];
                    result[j + 1] = temp;
                }
                continue;
            }
             if (order_map[char1] > order_map[char2]) {
                char temp = result[j];
                result[j] = result[j + 1];
                result[j + 1] = temp;
            }
        }
    }

    result[s_len] = '\0';
    return result;
}