#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    char *str1 = *(char **)a;
    char *str2 = *(char **)b;
    return strcmp(str1, str2);
}

char **highAccessEmployees(char ***access_times, int access_timesSize, int *access_timesColSize, int *returnSize) {
    char **result = (char **)malloc(access_timesSize * sizeof(char *));
    *returnSize = 0;

    qsort(access_times, access_timesSize, sizeof(char **), compare);

    for (int i = 0; i < access_timesSize - 2; i++) {
        if (strcmp(access_times[i][0], access_times[i + 2][0]) == 0) {
            int t1 = atoi(access_times[i][1]);
            int t2 = atoi(access_times[i + 1][1]);
            int t3 = atoi(access_times[i + 2][1]);

            int h1 = t1 / 100;
            int m1 = t1 % 100;
            int h2 = t2 / 100;
            int m2 = t2 % 100;
            int h3 = t3 / 100;
            int m3 = t3 % 100;

            int time1 = h1 * 60 + m1;
            int time2 = h2 * 60 + m2;
            int time3 = h3 * 60 + m3;

            if (time3 - time1 < 60) {
                int found = 0;
                for (int j = 0; j < *returnSize; j++) {
                    if (strcmp(result[j], access_times[i][0]) == 0) {
                        found = 1;
                        break;
                    }
                }
                if (!found) {
                    result[*returnSize] = (char *)malloc((strlen(access_times[i][0]) + 1) * sizeof(char));
                    strcpy(result[*returnSize], access_times[i][0]);
                    (*returnSize)++;
                }
            }
        }
    }

    return result;
}