#include <stdbool.h>

bool checkMove(char** board, int boardSize, int boardColSize, int rMove, int cMove, char color) {
    char my_color = color;
    char opponent_color = (color == 'B' ? 'W' : 'B');

    int dr[] = {-1, -1, -1, 0, 0, 1, 1, 1};
    int dc[] = {-1, 0, 1, -1, 1, -1, 0, 1};

    for (int i = 0; i < 8; i++) {
        int curr_r = rMove + dr[i];
        int curr_c = cMove + dc[i];
        int count_opponent_pieces = 0;

        if (curr_r >= 0 && curr_r < boardSize && curr_c >= 0 && curr_c < boardColSize) {
            if (board[curr_r][curr_c] == opponent_color) {
                count_opponent_pieces++;
                curr_r += dr[i];
                curr_c += dc[i];

                while (curr_r >= 0 && curr_r < boardSize && curr_c >= 0 && curr_c < boardColSize) {
                    if (board[curr_r][curr_c] == opponent_color) {
                        count_opponent_pieces++;
                        curr_r += dr[i];
                        curr_c += dc[i];
                    } else if (board[curr_r][curr_c] == my_color) {
                        if (count_opponent_pieces > 0) {
                            return true;
                        } else {
                            break; 
                        }
                    } else { 
                        break; 
                    }
                }
            }
        }
    }

    return false;
}