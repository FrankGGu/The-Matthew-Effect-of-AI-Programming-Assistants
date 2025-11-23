#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int flipChess(char** chessboard, int chessboardSize) {
    int rows = chessboardSize;
    int cols = strlen(chessboard[0]);
    int max_flips = 0;

    int dx[] = {-1, -1, -1, 0, 0, 1, 1, 1};
    int dy[] = {-1, 0, 1, -1, 1, -1, 0, 1};

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (chessboard[i][j] == '.') {
                int flips = 0;
                char temp_board[rows][cols + 1];
                for (int r = 0; r < rows; r++) {
                    strcpy(temp_board[r], chessboard[r]);
                }

                temp_board[i][j] = 'X';

                for (int d = 0; d < 8; d++) {
                    int x = i + dx[d];
                    int y = j + dy[d];
                    int count = 0;
                    bool found_x = false;

                    while (x >= 0 && x < rows && y >= 0 && y < cols) {
                        if (temp_board[x][y] == 'O') {
                            count++;
                        } else if (temp_board[x][y] == 'X') {
                            found_x = true;
                            break;
                        } else {
                            break;
                        }
                        x += dx[d];
                        y += dy[d];
                    }

                    if (found_x) {
                        x = i + dx[d];
                        y = j + dy[d];
                        while (temp_board[x][y] == 'O') {
                            flips++;
                            x += dx[d];
                            y += dy[d];
                        }
                    }
                }

                max_flips = (flips > max_flips) ? flips : max_flips;
            }
        }
    }

    return max_flips;
}