#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* username;
    int time;
} UserTime;

typedef struct {
    char* key;
    int count;
} Pair;

int compare(const void* a, const void* b) {
    return strcmp(((UserTime*)a)->username, ((UserTime*)b)->username);
}

int comparePair(const void* a, const void* b) {
    return ((Pair*)a)->count - ((Pair*)b)->count;
}

int* findingUsersActiveMinutes(char*** usersActivity, int usersActivitySize, int* usersActivityColSize, int* returnSize) {
    UserTime* userTimes = (UserTime*)malloc(usersActivitySize * sizeof(UserTime));
    for (int i = 0; i < usersActivitySize; i++) {
        userTimes[i].username = usersActivity[i][0];
        userTimes[i].time = usersActivity[i][1];
    }

    qsort(userTimes, usersActivitySize, sizeof(UserTime), compare);

    Pair* result = (Pair*)malloc(usersActivitySize * sizeof(Pair));
    int resultSize = 0;

    int i = 0;
    while (i < usersActivitySize) {
        char* currentUsername = userTimes[i].username;
        int uniqueTimeCount = 1;
        int j = i + 1;
        while (j < usersActivitySize && strcmp(userTimes[j].username, currentUsername) == 0) {
            if (userTimes[j].time != userTimes[j - 1].time) {
                uniqueTimeCount++;
            }
            j++;
        }
        result[resultSize].key = currentUsername;
        result[resultSize].count = uniqueTimeCount;
        resultSize++;
        i = j;
    }

    qsort(result, resultSize, sizeof(Pair), comparePair);

    int* output = (int*)malloc((resultSize + 1) * sizeof(int));
    int index = 0;
    for (int k = 0; k < resultSize; k++) {
        output[index++] = result[k].count;
    }
    *returnSize = index;

    free(userTimes);
    free(result);
    return output;
}