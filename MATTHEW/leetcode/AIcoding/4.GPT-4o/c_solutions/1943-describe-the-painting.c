typedef struct {
    int left;
    int top;
    int right;
    int bottom;
} Rectangle;

int describePainting(Rectangle* rectangles, int rectanglesSize) {
    long long totalArea = 0;
    int x1 = INT_MAX, y1 = INT_MAX, x2 = INT_MIN, y2 = INT_MIN;
    int areaCount[1000000] = {0};

    for (int i = 0; i < rectanglesSize; i++) {
        Rectangle r = rectangles[i];
        totalArea += (long long)(r.right - r.left) * (r.bottom - r.top);
        x1 = fmin(x1, r.left);
        y1 = fmin(y1, r.top);
        x2 = fmax(x2, r.right);
        y2 = fmax(y2, r.bottom);

        for (int x = r.left; x < r.right; x++) {
            for (int y = r.top; y < r.bottom; y++) {
                areaCount[x + y * 1000]++;
            }
        }
    }

    long long expectedArea = (long long)(x2 - x1) * (y2 - y1);
    if (totalArea != expectedArea) return 0;

    int corners = 0;
    for (int i = 0; i < rectanglesSize; i++) {
        Rectangle r = rectangles[i];
        int cornerCount[4] = {0};

        cornerCount[0] += (areaCount[r.left + r.top * 1000] == 1);
        cornerCount[1] += (areaCount[r.right + r.top * 1000] == 1);
        cornerCount[2] += (areaCount[r.left + r.bottom * 1000] == 1);
        cornerCount[3] += (areaCount[r.right + r.bottom * 1000] == 1);

        corners += cornerCount[0] + cornerCount[1] + cornerCount[2] + cornerCount[3];
    }

    return corners == 4 ? 1 : 0;
}