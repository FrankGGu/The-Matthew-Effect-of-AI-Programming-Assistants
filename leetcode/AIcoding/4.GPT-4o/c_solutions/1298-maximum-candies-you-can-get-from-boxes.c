#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX_BOXES 100

typedef struct {
    int boxIndex;
    bool opened;
} Box;

int maxCandies(int* boxes, int boxesSize, int* initialBoxes, int initialBoxesSize) {
    int totalCandies = 0;
    bool opened[MAX_BOXES] = {false};
    Box queue[MAX_BOXES];
    int front = 0, rear = 0;

    for (int i = 0; i < initialBoxesSize; i++) {
        queue[rear++] = (Box){initialBoxes[i], false};
        opened[initialBoxes[i]] = true;
    }

    while (front < rear) {
        Box currentBox = queue[front++];
        totalCandies += boxes[currentBox.boxIndex];

        for (int i = 0; i < boxes[currentBox.boxIndex]; i++) {
            if (!opened[i]) {
                opened[i] = true;
                queue[rear++] = (Box){i, false};
            }
        }
    }

    return totalCandies;
}