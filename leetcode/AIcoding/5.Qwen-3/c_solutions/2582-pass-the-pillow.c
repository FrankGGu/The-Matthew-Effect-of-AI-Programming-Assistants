#include <stdio.h>
#include <stdlib.h>

int passThePillow(int n, int time) {
    int direction = 1;
    int current = 1;
    for (int i = 0; i < time; i++) {
        if (current == n) {
            direction = -1;
        } else if (current == 1) {
            direction = 1;
        }
        current += direction;
    }
    return current;
}