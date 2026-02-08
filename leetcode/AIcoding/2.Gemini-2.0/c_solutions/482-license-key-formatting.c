#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * licenseKeyFormatting(char * s, int k){
    int len = strlen(s);
    int count = 0;
    for (int i = 0; i < len; i++) {
        if (s[i] != '-') {
            count++;
        }
    }

    if (count == 0) {
        char *result = (char*)malloc(sizeof(char));
        result[0] = '\0';
        return result;
    }

    int num_groups = (count % k == 0) ? (count / k) : (count / k + 1);
    int result_len = count + num_groups - 1;
    char *result = (char*)malloc(sizeof(char) * (result_len + 1));
    result[result_len] = '\0';

    int result_index = result_len - 1;
    int char_count = 0;

    for (int i = len - 1; i >= 0; i--) {
        if (s[i] != '-') {
            result[result_index] = toupper(s[i]);
            result_index--;
            char_count++;

            if (char_count == k && result_index >= 0) {
                result[result_index] = '-';
                result_index--;
                char_count = 0;
            }
        }
    }

    if (result_index >= 0 && result[result_index + 1] == '-') {
        return result + result_index + 2;
    } else {
        return result + result_index + 1;
    }
}