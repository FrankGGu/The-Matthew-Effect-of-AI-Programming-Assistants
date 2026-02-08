#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int is_digit_log(char *log) {
    char *space = strchr(log, ' ');
    if (space == NULL) return 0;
    space++;
    return (space[0] >= '0' && space[0] <= '9');
}

int compare_logs(const void *a, const void *b) {
    char *log1 = *(char **)a;
    char *log2 = *(char **)b;

    if (is_digit_log(log1) && is_digit_log(log2)) {
        return 0;
    } else if (is_digit_log(log1)) {
        return 1;
    } else if (is_digit_log(log2)) {
        return -1;
    } else {
        char *space1 = strchr(log1, ' ');
        char *space2 = strchr(log2, ' ');
        space1++;
        space2++;
        int content_cmp = strcmp(space1, space2);
        if (content_cmp != 0) {
            return content_cmp;
        } else {
            char *id1 = log1;
            char *id2 = log2;

            return strcmp(log1, log2);
        }
    }
}

char ** reorderLogFiles(char ** logs, int logsSize, int* returnSize){
    qsort(logs, logsSize, sizeof(char *), compare_logs);
    *returnSize = logsSize;
    return logs;
}