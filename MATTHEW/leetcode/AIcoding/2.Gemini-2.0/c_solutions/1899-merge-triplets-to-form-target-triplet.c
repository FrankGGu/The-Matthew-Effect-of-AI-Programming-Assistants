#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool mergeTriplets(int** triplets, int tripletsSize, int* tripletsColSize, int* target, int targetSize) {
    bool found[3] = {false, false, false};

    for (int i = 0; i < tripletsSize; i++) {
        if (triplets[i][0] <= target[0] && triplets[i][1] <= target[1] && triplets[i][2] <= target[2]) {
            if (triplets[i][0] == target[0]) {
                found[0] = true;
            }
            if (triplets[i][1] == target[1]) {
                found[1] = true;
            }
            if (triplets[i][2] == target[2]) {
                found[2] = true;
            }
        }
    }

    return found[0] && found[1] && found[2];
}