#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    char *s1 = *(char **)a;
    char *s2 = *(char **)b;
    return strcmp(s1, s2);
}

int cmp_time(const void *a, const void *b) {
    int t1 = *(int *)a;
    int t2 = *(int *)b;
    return t1 - t2;
}

char **alertNames(char **keyName, int keyNameSize, char **keyTime, int keyTimeSize, int *returnSize) {
    char **result = (char **)malloc(keyNameSize * sizeof(char *));
    *returnSize = 0;

    qsort(keyName, keyNameSize, sizeof(char *), cmp);

    char *currentName = NULL;
    int count = 0;
    int *times = (int *)malloc(keyNameSize * sizeof(int));
    int timeCount = 0;

    for (int i = 0; i < keyNameSize; i++) {
        int hour = (keyTime[i][0] - '0') * 10 + (keyTime[i][1] - '0');
        int minute = (keyTime[i][3] - '0') * 10 + (keyTime[i][4] - '0');
        int time = hour * 60 + minute;

        if (currentName == NULL || strcmp(keyName[i], currentName) != 0) {
            if (currentName != NULL && timeCount >= 3) {
                qsort(times, timeCount, sizeof(int), cmp_time);
                for (int j = 0; j < timeCount - 2; j++) {
                    if (times[j + 2] - times[j] <= 60) {
                        result[*returnSize] = strdup(currentName);
                        (*returnSize)++;
                        break;
                    }
                }
            }
            currentName = keyName[i];
            timeCount = 0;
        }
        times[timeCount++] = time;
    }

    if (currentName != NULL && timeCount >= 3) {
        qsort(times, timeCount, sizeof(int), cmp_time);
        for (int j = 0; j < timeCount - 2; j++) {
            if (times[j + 2] - times[j] <= 60) {
                int found = 0;
                for(int k = 0; k < *returnSize; k++){
                    if(strcmp(result[k], currentName) == 0){
                        found = 1;
                        break;
                    }
                }
                if(!found){
                    result[*returnSize] = strdup(currentName);
                    (*returnSize)++;
                }

                break;
            }
        }
    }

    qsort(result, *returnSize, sizeof(char *), cmp);

    free(times);
    return result;
}