#include <stdio.h>
#include <stdlib.h>

bool squareIsWhite(int x, int y) {
    return (x + y) % 2 == 1;
}

bool canTake(char* a, char* b) {
    int x1 = a[0] - 'a' + 1;
    int y1 = a[1] - '0';
    int x2 = b[0] - 'a' + 1;
    int y2 = b[1] - '0';
    return (x1 + y1) % 2 == (x2 + y2) % 2;
}