#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxCandies(int* status, int statusSize, int* candies, int candiesSize, int** keys, int* keysSize, int* containedBoxes, int containedBoxesSize, int* initialBoxes, int initialBoxesSize){
    int totalCandies = 0;
    bool* hasBox = (bool*)calloc(statusSize, sizeof(bool));
    bool* opened = (bool*)calloc(statusSize, sizeof(bool));
    bool* canOpen = (bool*)calloc(statusSize, sizeof(bool));
    int* q = (int*)malloc(sizeof(int) * statusSize);
    int q_size = 0;
    int q_head = 0;

    for (int i = 0; i < initialBoxesSize; i++) {
        hasBox[initialBoxes[i]] = true;
        q[q_size++] = initialBoxes[i];
    }

    while (q_head < q_size) {
        int boxIndex = q[q_head++];

        if (status[boxIndex] == 1 || canOpen[boxIndex]) {
            if (!opened[boxIndex]) {
                opened[boxIndex] = true;
                totalCandies += candies[boxIndex];

                for (int i = 0; i < keysSize[boxIndex]; i++) {
                    int keyIndex = keys[boxIndex][i];
                    if (!opened[keyIndex]) {
                        canOpen[keyIndex] = true;
                        if(hasBox[keyIndex]) {
                            q[q_size++] = keyIndex;
                        }
                    }
                }

                for (int i = 0; i < containedBoxesSize; i++) {
                    if (containedBoxes[i] == boxIndex) {
                        for (int j = 0; j < containedBoxesSize; j++) {
                            if(containedBoxes[j] != boxIndex) continue;
                            int newBoxIndex = containedBoxes[j];
                            if (!hasBox[newBoxIndex]) {
                                hasBox[newBoxIndex] = true;
                                if (status[newBoxIndex] == 1 || canOpen[newBoxIndex]) {
                                    q[q_size++] = newBoxIndex;
                                } else {
                                    q[q_size++] = newBoxIndex;
                                    q_size--;
                                }
                            }
                        }
                    }
                }
            }
        } else {
            q[q_size++] = boxIndex;
            if (q_head == q_size) {
                break;
            }
        }
    }

    free(hasBox);
    free(opened);
    free(canOpen);
    free(q);

    return totalCandies;
}