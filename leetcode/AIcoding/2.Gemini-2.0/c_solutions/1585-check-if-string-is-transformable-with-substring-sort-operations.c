#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isTransformable(char * s, char * t){
    int n = strlen(s);
    int m = strlen(t);

    if (n != m) {
        return false;
    }

    int s_indices[10][n];
    int s_counts[10] = {0};

    for (int i = 0; i < n; i++) {
        int digit = s[i] - '0';
        s_indices[digit][s_counts[digit]++] = i;
    }

    int t_indices[10] = {0};

    for (int i = 0; i < m; i++) {
        int target_digit = t[i] - '0';
        int target_index = t_indices[target_digit];

        if (s_counts[target_digit] == 0 || target_index >= s_counts[target_digit]) {
            return false;
        }

        int s_current_index = s_indices[target_digit][target_index];

        for (int j = 0; j < target_digit; j++) {
            if (s_counts[j] > 0) {
                for (int k = 0; k < s_counts[j]; k++) {
                    if (s_indices[j][k] < s_current_index) {
                        t_indices[target_digit]++;
                        goto next_target;
                    }
                }
            }
        }

        t_indices[target_digit]++;
        next_target:;
    }

    return true;
}