#include <stdio.h>
#include <stdlib.h>

int minBoxes(int n) {
    int boxes = 0;
    int level = 1;
    while (n > 0) {
        boxes += level;
        n -= level;
        level++;
    }
    return boxes;
}