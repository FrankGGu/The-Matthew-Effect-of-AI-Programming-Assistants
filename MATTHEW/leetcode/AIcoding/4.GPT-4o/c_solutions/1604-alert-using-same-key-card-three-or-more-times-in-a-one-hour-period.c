#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* keyName;
    int* time;
    int timeSize;
} KeyCard;

int* alertNames(char** keyName, int keyNameSize, int* returnSize) {
    int* result = (int*)malloc(keyNameSize * sizeof(int));
    *returnSize = 0;

    // Create a map to store keyName and their corresponding times
    KeyCard map[1000];
    int mapSize = 0;

    for (int i = 0; i < keyNameSize; i++) {
        int found = 0;
        for (int j = 0; j < mapSize; j++) {
            if (strcmp(map[j].keyName, keyName[i]) == 0) {
                map[j].time[map[j].timeSize++] = atoi(keyName[i + 1]) * 60 + atoi(keyName[i + 2]);
                found = 1;
                break;
            }
        }
        if (!found) {
            map[mapSize].keyName = keyName[i];
            map[mapSize].timeSize = 1;
            map[mapSize].time = (int*)malloc(sizeof(int));
            map[mapSize].time[0] = atoi(keyName[i + 1]) * 60 + atoi(keyName[i + 2]);
            mapSize++;
        }
    }

    // Check for alerts
    for (int i = 0; i < mapSize; i++) {
        int count = 0;
        for (int j = 0; j < map[i].timeSize; j++) {
            for (int k = j + 1; k < map[i].timeSize && map[i].time[k] - map[i].time[j] < 60; k++) {
                count++;
            }
        }
        if (count >= 3) {
            result[(*returnSize)++] = map[i].keyName;
        }
    }

    return result;
}