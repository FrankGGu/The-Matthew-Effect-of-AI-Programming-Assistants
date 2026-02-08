#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findMinStep(char *board, char *hand) {
    int boardLen = strlen(board);
    int handLen = strlen(hand);
    int minSteps = -1;

    int* handCount = (int*)calloc(5, sizeof(int));
    for (int i = 0; i < handLen; i++) {
        if (hand[i] == 'R') handCount[0]++;
        else if (hand[i] == 'Y') handCount[1]++;
        else if (hand[i] == 'B') handCount[2]++;
        else if (hand[i] == 'G') handCount[3]++;
        else if (hand[i] == 'W') handCount[4]++;
    }

    int solve(char* currentBoard, int* currentHandCount) {
        int currentBoardLen = strlen(currentBoard);
        if (currentBoardLen == 0) return 0;

        int minStepsNeeded = -1;

        for (int i = 0; i < currentBoardLen; i++) {
            int j = i;
            while (j < currentBoardLen && currentBoard[i] == currentBoard[j]) {
                j++;
            }
            int needed = 3 - (j - i);
            int colorIndex;
            if (currentBoard[i] == 'R') colorIndex = 0;
            else if (currentBoard[i] == 'Y') colorIndex = 1;
            else if (currentBoard[i] == 'B') colorIndex = 2;
            else if (currentBoard[i] == 'G') colorIndex = 3;
            else colorIndex = 4;

            if (currentHandCount[colorIndex] >= needed) {
                currentHandCount[colorIndex] -= needed;
                char* nextBoard = (char*)malloc(sizeof(char) * (strlen(currentBoard) + 1));
                strncpy(nextBoard, currentBoard, i);
                nextBoard[i] = '\0';
                strcat(nextBoard, currentBoard + j);

                int nextBoardLen = strlen(nextBoard);
                int k = 0;
                while (k < nextBoardLen) {
                    int l = k;
                    while (l < nextBoardLen && nextBoard[k] == nextBoard[l]) {
                        l++;
                    }
                    if (l - k >= 3) {
                        char* temp = (char*)malloc(sizeof(char) * (strlen(nextBoard) + 1));
                        strncpy(temp, nextBoard, k);
                        temp[k] = '\0';
                        strcat(temp, nextBoard + l);
                        free(nextBoard);
                        nextBoard = temp;
                        nextBoardLen = strlen(nextBoard);
                        k = 0;
                    } else {
                        k = l;
                    }
                }

                int steps = solve(nextBoard, currentHandCount);
                free(nextBoard);

                currentHandCount[colorIndex] += needed;

                if (steps != -1) {
                    if (minStepsNeeded == -1 || steps + needed < minStepsNeeded) {
                        minStepsNeeded = steps + needed;
                    }
                }
            }
            i = j - 1;
        }
        return minStepsNeeded;
    }

    minSteps = solve(board, handCount);
    free(handCount);
    return minSteps;
}