#include <stdio.h>
#include <stdlib.h>

char* findTheWinningPlayer(int n, int x) {
    if (n % (x + 1) == 0) {
        return "Second";
    } else {
        return "First";
    }
}