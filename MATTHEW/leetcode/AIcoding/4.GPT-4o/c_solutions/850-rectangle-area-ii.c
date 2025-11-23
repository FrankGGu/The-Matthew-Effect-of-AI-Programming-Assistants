#define MAX 10000

int rectangleArea(int** rectangles, int rectanglesSize, int* rectanglesColSize) {
    int mod = 1000000007;
    long long area = 0;
    int height[MAX] = {0};
    int xCoords[MAX * 2] = {0};
    int n = 0;

    for (int i = 0; i < rectanglesSize; i++) {
        xCoords[n++] = rectangles[i][0];
        xCoords[n++] = rectangles[i][2];
    }

    qsort(xCoords, n, sizeof(int), cmp);

    long long currentArea = 0;
    for (int i = 0; i < n - 1; i++) {
        int left = xCoords[i];
        int right = xCoords[i + 1];
        if (left == right) continue;

        memset(height, 0, sizeof(height));
        for (int j = 0; j < rectanglesSize; j++) {
            if (rectangles[j][0] <= left && rectangles[j][2] >= right) {
                height[rectangles[j][1]] += 1;
                height[rectangles[j][3]] -= 1;
            }
        }

        long long h = 0, sum = 0;
        for (int k = 0; k < MAX; k++) {
            sum += height[k];
            if (sum > 0) h = k;
            currentArea = (currentArea + (right - left) * h) % mod;
        }
    }

    return (int)currentArea;
}

int cmp(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}