#include <stdio.h>
#include <stdlib.h>

bool canBeFormed(int** triplets, int tripletsSize, int* target, int targetSize) {
    bool found = false;
    for (int i = 0; i < tripletsSize; i++) {
        if (triplets[i][0] == target[0] && triplets[i][1] == target[1] && triplets[i][2] == target[2]) {
            found = true;
            break;
        }
    }
    return found;
}

bool mergeTriplets(int** triplets, int tripletsSize, int* target, int targetSize) {
    bool found = false;
    for (int i = 0; i < tripletsSize; i++) {
        if (triplets[i][0] <= target[0] && triplets[i][1] <= target[1] && triplets[i][2] <= target[2]) {
            if (triplets[i][0] == target[0] && triplets[i][1] == target[1] && triplets[i][2] == target[2]) {
                found = true;
                break;
            }
        }
    }
    return found;
}