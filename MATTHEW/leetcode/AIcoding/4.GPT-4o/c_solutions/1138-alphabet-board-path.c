#include <string.h>

char *alphabetBoardPath(char *target) {
    int x = 0, y = 0;
    int len = strlen(target);
    char *result = (char *)malloc(len * 2 + 1);
    int index = 0;

    for (int i = 0; i < len; i++) {
        int newX = (target[i] - 'a') / 5;
        int newY = (target[i] - 'a') % 5;

        while (x > newX) {
            result[index++] = 'U';
            x--;
        }
        while (y > newY) {
            result[index++] = 'L';
            y--;
        }
        while (x < newX) {
            result[index++] = 'D';
            x++;
        }
        while (y < newY) {
            result[index++] = 'R';
            y++;
        }
        result[index++] = '!';
    }

    result[index] = '\0';
    return result;
}