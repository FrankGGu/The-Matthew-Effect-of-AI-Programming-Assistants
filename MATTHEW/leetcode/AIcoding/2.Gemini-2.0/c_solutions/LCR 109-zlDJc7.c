#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int openLock(char ** deadends, int deadendsSize, char * target){
    char *visited[10000] = {NULL};
    int visitedSize = 0;
    char queue[10000][5];
    int head = 0, tail = 0;
    int steps = 0;

    for (int i = 0; i < deadendsSize; i++) {
        if (strcmp(deadends[i], "0000") == 0) {
            return -1;
        }
        visited[visitedSize] = deadends[i];
        visitedSize++;
    }

    strcpy(queue[tail++], "0000");

    while (head < tail) {
        int qSize = tail - head;
        for (int i = 0; i < qSize; i++) {
            char curr[5];
            strcpy(curr, queue[head++]);

            if (strcmp(curr, target) == 0) {
                return steps;
            }

            for (int j = 0; j < 4; j++) {
                char nextUp[5];
                char nextDown[5];
                strcpy(nextUp, curr);
                strcpy(nextDown, curr);

                nextUp[j] = (nextUp[j] - '0' + 1) % 10 + '0';
                nextDown[j] = (nextDown[j] - '0' + 9) % 10 + '0';

                int isVisitedUp = 0;
                for (int k = 0; k < visitedSize; k++) {
                    if (strcmp(nextUp, visited[k]) == 0) {
                        isVisitedUp = 1;
                        break;
                    }
                }
                if (!isVisitedUp) {
                    strcpy(queue[tail++], nextUp);
                    visited[visitedSize++] = strdup(nextUp);
                }

                int isVisitedDown = 0;
                for (int k = 0; k < visitedSize; k++) {
                    if (strcmp(nextDown, visited[k]) == 0) {
                        isVisitedDown = 1;
                        break;
                    }
                }
                if (!isVisitedDown) {
                    strcpy(queue[tail++], nextDown);
                    visited[visitedSize++] = strdup(nextDown);
                }
            }
        }
        steps++;
    }

    return -1;
}