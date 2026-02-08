#include <stdlib.h> // For malloc, free, abs
#include <string.h> // For memset

#define MAX_COORD 1000
#define MAX_UNIQUE_POINTS 1000 // Maximum number of unique points that can be added, based on 1000 calls to add.

typedef struct {
    int count[MAX_COORD + 1][MAX_COORD + 1];
    // Stores unique [x, y] coordinates that have been added.
    // This allows iterating only over existing points, rather than all 1001x1001 grid cells,
    // optimizing the detectSquaresCount operation.
    int uniquePoints[MAX_UNIQUE_POINTS][2]; 
    int uniquePointsCount;
} DetectSquares;

DetectSquares* detectSquaresCreate() {
    DetectSquares* obj = (DetectSquares*)malloc(sizeof(DetectSquares));
    // Initialize the 2D count array to all zeros.
    // This sets the initial count of all points to 0.
    memset(obj->count, 0, sizeof(obj->count));
    // Initialize the counter for unique points to 0.
    obj->uniquePointsCount = 0;
    return obj;
}

void detectSquaresAdd(DetectSquares* obj, int* point, int pointSize) {
    int x = point[0];
    int y = point[1];

    // If this is the first time this specific (x, y) point is being added,
    // record its coordinates in the uniquePoints array.
    if (obj->count[x][y] == 0) {
        obj->uniquePoints[obj->uniquePointsCount][0] = x;
        obj->uniquePoints[obj->uniquePointsCount][1] = y;
        obj->uniquePointsCount++;
    }
    // Increment the count for this point in the 2D array.
    // This handles cases where the same point is added multiple times.
    obj->count[x][y]++;
}

int detectSquaresCount(DetectSquares* obj, int* point, int pointSize) {
    int qx = point[0]; // X-coordinate of the query point
    int qy = point[1]; // Y-coordinate of the query point
    int totalSquares = 0;

    // Iterate through all unique points (px, py) that have been added to the data structure.
    // We consider (qx, qy) and (px, py) as potential opposite corners of a square.
    for (int i = 0; i < obj->uniquePointsCount; i++) {
        int px = obj->uniquePoints[i][0];
        int py = obj->uniquePoints[i][1];

        // If px is the same as qx, or py is the same as qy,
        // these two points ((qx, qy) and (px, py)) cannot form a diagonal of a square.
        // This is because a diagonal requires both x and y coordinates to be different
        // for the two points, otherwise it would imply a side length of zero in one dimension,
        // or the points are identical.
        if (px == qx || py == qy) {
            continue;
        }

        // For (qx, qy) and (px, py) to be opposite corners of a square,
        // the absolute difference in their x-coordinates must be equal to
        // the absolute difference in their y-coordinates.
        // This condition ensures that the square has equal side lengths.
        if (abs(px - qx) == abs(py - qy)) {
            // If they are opposite corners, the other two corners of the square would be:
            // (qx, py) and (px, qy).
            // We need to check if these two points also exist in our data structure
            // (i.e., their counts are greater than 0).
            // The number of squares formed using (qx, qy) as one corner, (px, py) as the opposite corner,
            // and (qx, py) and (px, qy) as the other two corners, is the product of their counts.
            // This correctly handles cases where multiple identical points have been added,
            // as each instance can form a distinct square.
            totalSquares += obj->count[px][py] * obj->count[qx][py] * obj->count[px][qy];
        }
    }
    return totalSquares;
}

void detectSquaresFree(DetectSquares* obj) {
    // Free the memory allocated for the DetectSquares object.
    free(obj);
}