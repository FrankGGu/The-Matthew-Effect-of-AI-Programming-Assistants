#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int id;
    int x;
    int y;
} Room;

typedef struct {
    int* rooms;
    int size;
} Result;

int compareRoom(const void* a, const void* b) {
    Room* roomA = (Room*)a;
    Room* roomB = (Room*)b;
    return roomA->id - roomB->id;
}

int compareDistance(const void* a, const void* b) {
    int* roomA = (int*)a;
    int* roomB = (int*)b;
    return *roomA - *roomB;
}

Result* closestRoom(int** rooms, int roomsSize, int* requests, int requestsSize) {
    Room* roomList = (Room*)malloc(roomsSize * sizeof(Room));
    for (int i = 0; i < roomsSize; i++) {
        roomList[i].id = rooms[i][0];
        roomList[i].x = rooms[i][1];
        roomList[i].y = rooms[i][2];
    }
    qsort(roomList, roomsSize, sizeof(Room), compareRoom);

    Result* result = (Result*)malloc(requestsSize * sizeof(Result));
    for (int i = 0; i < requestsSize; i++) {
        int requestX = requests[i];
        int requestY = requests[i + 1];
        i++;

        int* distances = (int*)malloc(roomsSize * sizeof(int));
        for (int j = 0; j < roomsSize; j++) {
            int dx = roomList[j].x - requestX;
            int dy = roomList[j].y - requestY;
            distances[j] = dx * dx + dy * dy;
        }

        int* sortedRooms = (int*)malloc(roomsSize * sizeof(int));
        for (int j = 0; j < roomsSize; j++) {
            sortedRooms[j] = roomList[j].id;
        }
        qsort(sortedRooms, roomsSize, sizeof(int), compareDistance);

        result[i - 1].rooms = sortedRooms;
        result[i - 1].size = roomsSize;
    }

    return result;
}