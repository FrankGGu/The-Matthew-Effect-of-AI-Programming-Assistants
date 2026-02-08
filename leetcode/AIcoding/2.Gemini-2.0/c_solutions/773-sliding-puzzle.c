#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int slidingPuzzle(int** board, int boardSize, int* boardColSize) {
    char target[] = "123450";
    char start[7];
    int k = 0;
    for (int i = 0; i < boardSize; i++) {
        for (int j = 0; j < boardColSize[i]; j++) {
            start[k++] = board[i][j] + '0';
        }
    }
    start[6] = '\0';

    if (strcmp(start, target) == 0) return 0;

    int dirs[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
    int queue[100000];
    int head = 0, tail = 0;
    queue[tail++] = 0;

    int visited[720 * 7]; 
    memset(visited, 0, sizeof(visited));

    int start_val = 0;
    char temp[7];
    strcpy(temp, start);
    int factorial[7] = {1, 1, 2, 6, 24, 120, 720};
    for (int i = 0; i < 6; i++) {
        int count = 0;
        for (int j = i + 1; j < 6; j++) {
            if (temp[j] < temp[i]) {
                count++;
            }
        }
        start_val += count * factorial[5 - i];
    }

    visited[start_val] = 1;

    int steps = 0;
    while (head < tail) {
        int queueSize = tail - head;
        for (int i = 0; i < queueSize; i++) {
            char current[7];
            strcpy(current, start);

            int zeroIndex = -1;
            for (int j = 0; j < 6; j++) {
                if (current[j] == '0') {
                    zeroIndex = j;
                    break;
                }
            }

            int row = zeroIndex / 3;
            int col = zeroIndex % 3;

            for (int j = 0; j < 4; j++) {
                int newRow = row + dirs[j][0];
                int newCol = col + dirs[j][1];

                if (newRow >= 0 && newRow < 2 && newCol >= 0 && newCol < 3) {
                    int newIndex = newRow * 3 + newCol;

                    char next[7];
                    strcpy(next, current);
                    char tempChar = next[zeroIndex];
                    next[zeroIndex] = next[newIndex];
                    next[newIndex] = tempChar;

                    if (strcmp(next, target) == 0) return steps + 1;

                    int next_val = 0;
                    strcpy(temp, next);
                    for (int l = 0; l < 6; l++) {
                        int count = 0;
                        for (int m = l + 1; m < 6; m++) {
                            if (temp[m] < temp[l]) {
                                count++;
                            }
                        }
                        next_val += count * factorial[5 - l];
                    }

                    if (!visited[next_val]) {
                        visited[next_val] = 1;
                        strcpy(start, next);
                        queue[tail++] = 0;
                        strcpy(start, current);
                    }
                }
            }
            head++;
        }
        steps++;
    }

    return -1;
}