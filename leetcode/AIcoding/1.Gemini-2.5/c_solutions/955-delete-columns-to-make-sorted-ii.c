#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

int minDeletionSize(char **strs, int strsSize) {
    if (strsSize <= 1) {
        return 0;
    }

    int m = strsSize;
    int n = strlen(strs[0]);
    int deleted_count = 0;

    bool *is_sorted_fixed = (bool *)malloc((m - 1) * sizeof(bool));
    for (int i = 0; i < m - 1; ++i) {
        is_sorted_fixed[i] = false;
    }

    for (int j = 0; j < n; ++j) {
        bool should_delete_current_column = false;
        for (int i = 0; i < m - 1; ++i) {
            if (is_sorted_fixed[i]) {
                continue;
            }

            if (strs[i][j] > strs[i+1][j]) {
                should_delete_current_column = true;
                deleted_count++;
                break;
            }
        }

        if (!should_delete_current_column) {
            for (int i = 0; i < m - 1; ++i) {
                if (!is_sorted_fixed[i] && strs[i][j] < strs[i+1][j]) {
                    is_sorted_fixed[i] = true;
                }
            }
        }
    }

    free(is_sorted_fixed);
    return deleted_count;
}