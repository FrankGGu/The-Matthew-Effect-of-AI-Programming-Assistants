#include <stdlib.h>

struct Room {
    int id;
    int size;
};

int cmp(const void *a, const void *b) {
    return ((struct Room *)b)->size - ((struct Room *)a)->size;
}

int* closestRoom(int** rooms, int roomsSize, int* roomsColSize, int* queries, int queriesSize, int* returnSize) {
    int *results = (int *)malloc(queriesSize * sizeof(int));
    int *sizes = (int *)malloc(roomsSize * sizeof(int));
    struct Room *roomArr = (struct Room *)malloc(roomsSize * sizeof(struct Room));

    for (int i = 0; i < roomsSize; i++) {
        roomArr[i].id = rooms[i][0];
        roomArr[i].size = rooms[i][1];
    }

    qsort(roomArr, roomsSize, sizeof(struct Room), cmp);

    for (int i = 0; i < queriesSize; i++) {
        results[i] = -1;
        for (int j = 0; j < roomsSize; j++) {
            if (roomArr[j].size >= queries[i]) {
                if (results[i] == -1 || roomArr[j].id < results[i]) {
                    results[i] = roomArr[j].id;
                }
            }
        }
    }

    free(roomArr);
    *returnSize = queriesSize;
    return results;
}