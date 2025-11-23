/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* countRectangles(int** rectangles, int rectanglesSize, int* rectanglesColSize, int** points, int pointsSize, int* pointsColSize, int* returnSize) {
    int* res = (int*)malloc(pointsSize * sizeof(int));
    *returnSize = pointsSize;

    // Group rectangles by height
    int max_h = 0;
    for (int i = 0; i < rectanglesSize; i++) {
        if (rectangles[i][1] > max_h) {
            max_h = rectangles[i][1];
        }
    }

    int** buckets = (int**)malloc((max_h + 1) * sizeof(int*));
    int* sizes = (int*)calloc((max_h + 1), sizeof(int));
    int* capacities = (int*)calloc((max_h + 1), sizeof(int));

    for (int i = 0; i <= max_h; i++) {
        capacities[i] = 10;
        buckets[i] = (int*)malloc(capacities[i] * sizeof(int));
    }

    for (int i = 0; i < rectanglesSize; i++) {
        int h = rectangles[i][1];
        if (sizes[h] >= capacities[h]) {
            capacities[h] *= 2;
            buckets[h] = (int*)realloc(buckets[h], capacities[h] * sizeof(int));
        }
        buckets[h][sizes[h]++] = rectangles[i][0];
    }

    // Sort each bucket
    for (int i = 0; i <= max_h; i++) {
        if (sizes[i] > 0) {
            for (int j = 0; j < sizes[i] - 1; j++) {
                for (int k = j + 1; k < sizes[i]; k++) {
                    if (buckets[i][j] > buckets[i][k]) {
                        int temp = buckets[i][j];
                        buckets[i][j] = buckets[i][k];
                        buckets[i][k] = temp;
                    }
                }
            }
        }
    }

    // For each point, count rectangles
    for (int i = 0; i < pointsSize; i++) {
        int x = points[i][0];
        int y = points[i][1];
        int count = 0;

        for (int h = y; h <= max_h; h++) {
            if (sizes[h] == 0) continue;

            // Binary search for first width >= x
            int left = 0, right = sizes[h] - 1;
            int idx = sizes[h];
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (buckets[h][mid] >= x) {
                    idx = mid;
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }
            count += (sizes[h] - idx);
        }
        res[i] = count;
    }

    // Free memory
    for (int i = 0; i <= max_h; i++) {
        free(buckets[i]);
    }
    free(buckets);
    free(sizes);
    free(capacities);

    return res;
}