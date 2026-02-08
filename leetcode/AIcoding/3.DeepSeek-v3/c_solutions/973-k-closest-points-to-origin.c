/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** kClosest(int** points, int pointsSize, int* pointsColSize, int k, int* returnSize, int** returnColumnSizes) {
    int* distances = malloc(pointsSize * sizeof(int));
    for (int i = 0; i < pointsSize; i++) {
        distances[i] = points[i][0] * points[i][0] + points[i][1] * points[i][1];
    }

    int** result = malloc(k * sizeof(int*));
    *returnColumnSizes = malloc(k * sizeof(int));
    *returnSize = k;

    for (int i = 0; i < k; i++) {
        (*returnColumnSizes)[i] = 2;
    }

    for (int i = 0; i < k; i++) {
        int minIndex = i;
        for (int j = i + 1; j < pointsSize; j++) {
            if (distances[j] < distances[minIndex]) {
                minIndex = j;
            }
        }

        int tempDist = distances[i];
        distances[i] = distances[minIndex];
        distances[minIndex] = tempDist;

        int* tempPoint = points[i];
        points[i] = points[minIndex];
        points[minIndex] = tempPoint;

        result[i] = malloc(2 * sizeof(int));
        result[i][0] = points[i][0];
        result[i][1] = points[i][1];
    }

    free(distances);
    return result;
}