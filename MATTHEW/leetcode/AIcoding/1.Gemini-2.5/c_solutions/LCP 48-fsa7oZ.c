#include <stdbool.h>

bool canWin(int x, int y) {
    return (x ^ y) != 0;
}