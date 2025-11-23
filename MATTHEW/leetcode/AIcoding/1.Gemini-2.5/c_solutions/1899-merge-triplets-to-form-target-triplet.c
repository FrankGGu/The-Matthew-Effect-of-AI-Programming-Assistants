#include <stdbool.h>

bool mergeTriplets(int** triplets, int tripletsSize, int* tripletsColSize, int* target, int targetSize) {
    bool foundX = false;
    bool foundY = false;
    bool foundZ = false;

    int tx = target[0];
    int ty = target[1];
    int tz = target[2];

    for (int i = 0; i < tripletsSize; i++) {
        int cx = triplets[i][0];
        int cy = triplets[i][1];
        int cz = triplets[i][2];

        if (cx <= tx && cy <= ty && cz <= tz) {
            if (cx == tx) {
                foundX = true;
            }
            if (cy == ty) {
                foundY = true;
            }
            if (cz == tz) {
                foundZ = true;
            }
        }

        if (foundX && foundY && foundZ) {
            return true;
        }
    }

    return foundX && foundY && foundZ;
}