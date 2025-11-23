#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    int size;
} Room;

int compareRooms(const void *a, const void *b) {
    return ((Room *)b)->size - ((Room *)a)->size;
}

int compareQueries(const void *a, const void *b) {
    return ((int *)b)[1] - ((int *)a)[1];
}

int* closestRoom(int** rooms, int roomsSize, int* roomsColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    Room* roomArray = (Room*)malloc(roomsSize * sizeof(Room));
    for (int i = 0; i < roomsSize; i++) {
        roomArray[i].id = rooms[i][0];
        roomArray[i].size = rooms[i][1];
    }
    qsort(roomArray, roomsSize, sizeof(Room), compareRooms);

    int** indexedQueries = (int**)malloc(queriesSize * sizeof(int*));
    for (int i = 0; i < queriesSize; i++) {
        indexedQueries[i] = (int*)malloc(3 * sizeof(int));
        indexedQueries[i][0] = i;
        indexedQueries[i][1] = queries[i][1];
        indexedQueries[i][2] = queries[i][0];
    }
    qsort(indexedQueries, queriesSize, sizeof(int*), compareQueries);

    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    int* availableRooms = (int*)malloc(roomsSize * sizeof(int));
    int availableRoomsSize = 0;

    int roomIndex = 0;
    for (int i = 0; i < queriesSize; i++) {
        int queryIndex = indexedQueries[i][0];
        int minSize = indexedQueries[i][1];
        int preferredId = indexedQueries[i][2];

        while (roomIndex < roomsSize && roomArray[roomIndex].size >= minSize) {
            availableRooms[availableRoomsSize++] = roomArray[roomIndex].id;
            roomIndex++;
        }

        if (availableRoomsSize == 0) {
            result[queryIndex] = -1;
        } else {
            int closestId = availableRooms[0];
            int minDiff = abs(availableRooms[0] - preferredId);
            for (int j = 1; j < availableRoomsSize; j++) {
                int diff = abs(availableRooms[j] - preferredId);
                if (diff < minDiff) {
                    minDiff = diff;
                    closestId = availableRooms[j];
                }
            }
            result[queryIndex] = closestId;
        }
    }

    int* finalResult = (int*)malloc(queriesSize * sizeof(int));
    for(int i = 0; i < queriesSize; i++){
        finalResult[i] = result[i];
    }

    free(result);
    free(availableRooms);
    for (int i = 0; i < queriesSize; i++) {
        free(indexedQueries[i]);
    }
    free(indexedQueries);
    free(roomArray);

    return finalResult;
}