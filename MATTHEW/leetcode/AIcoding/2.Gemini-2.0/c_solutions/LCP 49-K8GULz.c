#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canTraverseAllRooms(int* rooms, int roomsSize) {
    bool* visited = (bool*)calloc(roomsSize, sizeof(bool));
    int count = 0;
    int queue[roomsSize];
    int head = 0, tail = 0;

    visited[0] = true;
    queue[tail++] = 0;
    count++;

    while (head < tail) {
        int roomIndex = queue[head++];
        int jump = rooms[roomIndex];
        int nextRoomIndex = (roomIndex + jump) % roomsSize;
        if (nextRoomIndex < 0) {
            nextRoomIndex += roomsSize;
        }

        if (!visited[nextRoomIndex]) {
            visited[nextRoomIndex] = true;
            queue[tail++] = nextRoomIndex;
            count++;
        }
        if (count == roomsSize) {
            break;
        }
    }

    free(visited);
    return count == roomsSize;
}