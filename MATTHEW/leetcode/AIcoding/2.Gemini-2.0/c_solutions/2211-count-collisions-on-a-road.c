#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countCollisions(char * directions) {
    int collisions = 0;
    int n = 0;
    while (directions[n] != '\0') {
        n++;
    }

    int left = 0;
    int right = n - 1;

    while (left < n && directions[left] == 'L') {
        left++;
    }

    while (right >= 0 && directions[right] == 'R') {
        right--;
    }

    for (int i = left; i <= right; i++) {
        if (directions[i] == 'R') {
            collisions++;
        } else if (directions[i] == 'L') {
            collisions++;
        } else if (directions[i] == 'S') {
            continue;
        }
    }

    return collisions;
}