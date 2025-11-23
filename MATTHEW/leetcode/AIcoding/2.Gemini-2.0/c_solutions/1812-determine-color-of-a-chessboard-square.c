#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool squareIsWhite(char coordinates[]) {
    int row = coordinates[1] - '0';
    int col = coordinates[0] - 'a' + 1;
    return (row + col) % 2 == 1;
}