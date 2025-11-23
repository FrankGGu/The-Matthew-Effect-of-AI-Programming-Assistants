#include <string.h>
#include <stdio.h>
#include <stdlib.h>

char *digitSum(char *s, int k) {
    char buffer1[305];
    char buffer2[305];

    char *current_s_ptr = buffer1;
    char *next_s_ptr = buffer2;

    strcpy(current_s_ptr, s);

    while (strlen(current_s_ptr) > k) {
        int next_s_idx = 0;
        int current_len = strlen(current_s_ptr);

        for (int i = 0; i < current_len; i += k) {
            int current_group_sum = 0;
            for (int j = 0; j < k && (i + j) < current_len; ++j) {
                current_group_sum += (current_s_ptr[i + j] - '0');
            }
            next_s_idx += sprintf(next_s_ptr + next_s_idx, "%d", current_group_sum);
        }
        next_s_ptr[next_s_idx] = '\0';

        char *temp = current_s_ptr;
        current_s_ptr = next_s_ptr;
        next_s_ptr = temp;
    }

    return strdup(current_s_ptr);
}