#include <stdbool.h>

bool squareIsWhite(char* coordinates) {
    int col = coordinates[0] - 'a';
    int row = coordinates[1] - '1';

    if ((col + row) % 2 == 0) {
        return false; // Even sum means black (if a1 is black)
    } else {
        return true;  // Odd sum means white (if a1 is black)
    }
}