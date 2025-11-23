#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* squareIsWhite(char* coordinates) {
    int x = coordinates[0] - 'a';
    int y = coordinates[1] - '1';
    if ((x + y) % 2 == 0) {
        return "false";
    } else {
        return "true";
    }
}