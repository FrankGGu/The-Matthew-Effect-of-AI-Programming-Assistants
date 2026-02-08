#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    int size;
} Room;

typedef struct {
    int preferred;
    int minSize;
    int index;
} Query;

int compareRoom(const void* a, const void* b) {
    Room* roomA = (Room*)a;
    Room* roomB = (Room*)b;
    return roomB->size - roomA->size;
}

int compareQuery(const void* a, const void* b) {
    Query* queryA = (Query*)a;
    Query* queryB = (Query*)b;
    return queryB->minSize - queryA->minSize;
}

int* closestRoom(int** rooms, int roomsSize, int* roomsColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    Room* roomList = (Room*)malloc(roomsSize * sizeof(Room));
    for (int i = 0; i < roomsSize; i++) {
        roomList[i].id = rooms[i][0];
        roomList[i].size = rooms[i][1];
    }

    Query* queryList = (Query*)malloc(queriesSize * sizeof(Query));
    for (int i = 0; i < queriesSize; i++) {
        queryList[i].preferred = queries[i][0];
        queryList[i].minSize = queries[i][1];
        queryList[i].index = i;
    }

    qsort(roomList, roomsSize, sizeof(Room), compareRoom);
    qsort(queryList, queriesSize, sizeof(Query), compareQuery);

    int* result = (int*)malloc(queriesSize * sizeof(int));
    memset(result, -1, queriesSize * sizeof(int));

    int roomIdx = 0;
    int* sortedIds = (int*)malloc(roomsSize * sizeof(int));
    int sortedSize = 0;

    for (int i = 0; i < queriesSize; i++) {
        int preferred = queryList[i].preferred;
        int minSize = queryList[i].minSize;
        int idx = queryList[i].index;

        while (roomIdx < roomsSize && roomList[roomIdx].size >= minSize) {
            int insertPos = sortedSize;
            for (int j = 0; j < sortedSize; j++) {
                if (roomList[roomIdx].id < sortedIds[j]) {
                    insertPos = j;
                    break;
                }
            }

            for (int j = sortedSize; j > insertPos; j--) {
                sortedIds[j] = sortedIds[j - 1];
            }
            sortedIds[insertPos] = roomList[roomIdx].id;
            sortedSize++;
            roomIdx++;
        }

        if (sortedSize == 0) {
            result[idx] = -1;
            continue;
        }

        int left = 0, right = sortedSize - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (sortedIds[mid] == preferred) {
                result[idx] = sortedIds[mid];
                break;
            } else if (sortedIds[mid] < preferred) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        if (result[idx] == -1) {
            int candidate1 = -1, candidate2 = -1;
            if (left < sortedSize) candidate1 = sortedIds[left];
            if (right >= 0) candidate2 = sortedIds[right];

            if (candidate1 == -1) {
                result[idx] = candidate2;
            } else if (candidate2 == -1) {
                result[idx] = candidate1;
            } else {
                int diff1 = abs(candidate1 - preferred);
                int diff2 = abs(candidate2 - preferred);
                if (diff1 < diff2 || (diff1 == diff2 && candidate1 < candidate2)) {
                    result[idx] = candidate1;
                } else {
                    result[idx] = candidate2;
                }
            }
        }
    }

    free(roomList);
    free(queryList);
    free(sortedIds);

    *returnSize = queriesSize;
    return result;
}