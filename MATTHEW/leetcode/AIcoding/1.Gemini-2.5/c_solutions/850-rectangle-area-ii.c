#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

#define MAX_RECTS 200
#define MAX_EVENTS (MAX_RECTS * 2)
#define MAX_Y_COORDS (MAX_RECTS * 2)
#define MOD 1000000007

typedef struct {
    int x;
    int y1;
    int y2;
    int type; // +1 for start of rectangle, -1 for end
} Event;

typedef struct {
    long long count;  // Number of active rectangles covering this segment
    long long length; // Length of the union of active intervals in this segment
} SegTreeNode;

SegTreeNode segTree[MAX_Y_COORDS * 4];

int uniqueY[MAX_Y_COORDS];
int numUniqueY;

int compareInts(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int compareEvents(const void *a, const void *b) {
    Event *eventA = (Event *)a;
    Event *eventB = (Event *)b;
    if (eventA->x != eventB->x) {
        return eventA->x - eventB->x;
    }
    return (eventA->type == 1) - (eventB->type == 1);
}

void updateSegTree(int nodeIdx, int segStartIdx, int segEndIdx, int targetY1Idx, int targetY2Idx, int type) {
    if (segStartIdx >= targetY2Idx || segEndIdx <= targetY1Idx) {
        return;
    }

    if (segStartIdx >= targetY1Idx && segEndIdx <= targetY2Idx) {
        segTree[nodeIdx].count += type;
    } else {
        int midIdx = segStartIdx + (segEndIdx - segStartIdx) / 2;
        updateSegTree(nodeIdx * 2, segStartIdx, midIdx, targetY1Idx, targetY2Idx, type);
        updateSegTree(nodeIdx * 2 + 1, midIdx, segEndIdx, targetY1Idx, targetY2Idx, type);
    }

    if (segTree[nodeIdx].count > 0) {
        segTree[nodeIdx].length = uniqueY[segEndIdx] - uniqueY[segStartIdx];
    } else {
        if (segStartIdx + 1 == segEndIdx) { // Leaf node
            segTree[nodeIdx].length = 0;
        } else {
            segTree[nodeIdx].length = segTree[nodeIdx * 2].length + segTree[nodeIdx * 2 + 1].length;
        }
    }
}

int findYIndex(int y_val) {
    int low = 0, high = numUniqueY - 1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (uniqueY[mid] == y_val) {
            return mid;
        } else if (uniqueY[mid] < y_val) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return -1;
}

long long rectangleArea(int** rectangles, int rectanglesSize, int* rectanglesColSize) {
    if (rectanglesSize == 0) {
        return 0;
    }

    Event events[MAX_EVENTS];
    int eventCount = 0;

    int yCoordsBuffer[MAX_Y_COORDS];
    int yCoordsBufferCount = 0;

    for (int i = 0; i < rectanglesSize; i++) {
        int x1 = rectangles[i][0];
        int y1 = rectangles[i][1];
        int x2 = rectangles[i][2];
        int y2 = rectangles[i][3];

        if (x1 == x2 || y1 == y2) continue; // Skip zero-area rectangles

        events[eventCount++] = (Event){x1, y1, y2, 1};
        events[eventCount++] = (Event){x2, y1, y2, -1};

        yCoordsBuffer[yCoordsBufferCount++] = y1;
        yCoordsBuffer[yCoordsBufferCount++] = y2;
    }

    if (eventCount == 0) return 0;

    qsort(yCoordsBuffer, yCoordsBufferCount, sizeof(int), compareInts);

    numUniqueY = 0;
    if (yCoordsBufferCount > 0) {
        uniqueY[numUniqueY++] = yCoordsBuffer[0];
        for (int i = 1; i < yCoordsBufferCount; i++) {
            if (yCoordsBuffer[i] != yCoordsBuffer[i-1]) {
                uniqueY[numUniqueY++] = yCoordsBuffer[i];
            }
        }
    }

    qsort(events, eventCount, sizeof(Event), compareEvents);

    long long totalArea = 0;
    int prevX = events[0].x;

    for (int i = 0; i < eventCount; i++) {
        int currentX = events[i].x;

        if (currentX > prevX) {
            long long currentHeight = segTree[1].length; // Root node (index 1) stores total length
            long long width = currentX - prevX;
            totalArea = (totalArea + (currentHeight * width) % MOD) % MOD;
        }

        int y1Idx = findYIndex(events[i].y1);
        int y2Idx = findYIndex(events[i].y2);

        if (y1Idx != -1 && y2Idx != -1) {
            updateSegTree(1, 0, numUniqueY - 1, y1Idx, y2Idx, events[i].type);
        }

        prevX = currentX;
    }

    return totalArea;
}