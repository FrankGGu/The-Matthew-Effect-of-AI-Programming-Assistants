#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** ambiguousCoordinates(char * s, int* returnSize){
    int n = strlen(s);
    s[n - 1] = '\0';
    s++;
    n -= 2;

    char **result = (char **)malloc(sizeof(char *) * 1000);
    *returnSize = 0;

    for (int i = 1; i < n; i++) {
        char left[n + 1];
        strncpy(left, s, i);
        left[i] = '\0';

        char right[n + 1];
        strncpy(right, s + i, n - i);
        right[n - i] = '\0';

        char **left_parts = (char **)malloc(sizeof(char *) * 20);
        int left_count = 0;

        char **right_parts = (char **)malloc(sizeof(char *) * 20);
        int right_count = 0;

        bool leading_zero_left = (left[0] == '0' && strlen(left) > 1);
        bool trailing_zero_left = (left[strlen(left) - 1] == '0');

        if (!leading_zero_left && !trailing_zero_left) {
            left_parts[left_count] = strdup(left);
            left_count++;
        }

        for (int j = 1; j < strlen(left); j++) {
            char temp[n + 2];
            strncpy(temp, left, j);
            temp[j] = '\0';
            strcat(temp, ".");
            strcat(temp, left + j);

            bool leading_zero = (left[0] == '0' && j > 1);
            bool trailing_zero = (left[strlen(left) - 1] == '0');
            if (!leading_zero && !trailing_zero) {
                left_parts[left_count] = strdup(temp);
                left_count++;
            }
        }

        bool leading_zero_right = (right[0] == '0' && strlen(right) > 1);
        bool trailing_zero_right = (right[strlen(right) - 1] == '0');

        if (!leading_zero_right && !trailing_zero_right) {
            right_parts[right_count] = strdup(right);
            right_count++;
        }

        for (int j = 1; j < strlen(right); j++) {
            char temp[n + 2];
            strncpy(temp, right, j);
            temp[j] = '\0';
            strcat(temp, ".");
            strcat(temp, right + j);

            bool leading_zero = (right[0] == '0' && j > 1);
            bool trailing_zero = (right[strlen(right) - 1] == '0');
            if (!leading_zero && !trailing_zero) {
                right_parts[right_count] = strdup(temp);
                right_count++;
            }
        }

        for (int j = 0; j < left_count; j++) {
            for (int k = 0; k < right_count; k++) {
                char temp[n + 10];
                sprintf(temp, "(%s, %s)", left_parts[j], right_parts[k]);
                result[*returnSize] = strdup(temp);
                (*returnSize)++;
            }
        }

        for(int j=0; j<left_count; j++){
            free(left_parts[j]);
        }
        free(left_parts);

        for(int j=0; j<right_count; j++){
            free(right_parts[j]);
        }
        free(right_parts);
    }

    return result;
}