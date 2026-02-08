typedef struct {
    int x;
    int y1;
    int y2;
    int type;
} Event;

int cmp(const void* a, const void* b) {
    Event* e1 = (Event*)a;
    Event* e2 = (Event*)b;
    return e1->x - e2->x;
}

int rectangleArea(int** rectangles, int rectanglesSize, int* rectanglesColSize) {
    int MOD = 1000000007;
    Event events[rectanglesSize * 2];
    int eventCount = 0;
    int yVals[rectanglesSize * 2];
    int yCount = 0;

    for (int i = 0; i < rectanglesSize; i++) {
        int x1 = rectangles[i][0];
        int y1 = rectangles[i][1];
        int x2 = rectangles[i][2];
        int y2 = rectangles[i][3];

        events[eventCount++] = (Event){x1, y1, y2, 1};
        events[eventCount++] = (Event){x2, y1, y2, -1};

        yVals[yCount++] = y1;
        yVals[yCount++] = y2;
    }

    qsort(events, eventCount, sizeof(Event), cmp);
    qsort(yVals, yCount, sizeof(int), cmp);

    int uniqueYCount = 0;
    for (int i = 0; i < yCount; i++) {
        if (i == 0 || yVals[i] != yVals[i - 1]) {
            yVals[uniqueYCount++] = yVals[i];
        }
    }

    int count[uniqueYCount - 1];
    memset(count, 0, sizeof(count));

    long long area = 0;
    int lastX = events[0].x;

    for (int i = 0; i < eventCount; i++) {
        Event e = events[i];
        int x = e.x;
        int y1 = e.y1;
        int y2 = e.y2;
        int type = e.type;

        long long currentY = 0;
        for (int j = 0; j < uniqueYCount - 1; j++) {
            if (count[j] > 0) {
                currentY += yVals[j + 1] - yVals[j];
            }
        }

        area += currentY * (x - lastX);
        area %= MOD;

        for (int j = 0; j < uniqueYCount - 1; j++) {
            if (yVals[j] >= y1 && yVals[j + 1] <= y2) {
                count[j] += type;
            }
        }

        lastX = x;
    }

    return area % MOD;
}