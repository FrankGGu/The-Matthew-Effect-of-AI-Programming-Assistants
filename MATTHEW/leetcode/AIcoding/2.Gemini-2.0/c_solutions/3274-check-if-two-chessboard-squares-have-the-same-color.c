#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool squareIsWhite(char coordinates[]) {
    int col = coordinates[0] - 'a' + 1;
    int row = coordinates[1] - '0';

    return (col + row) % 2 != 0;
}