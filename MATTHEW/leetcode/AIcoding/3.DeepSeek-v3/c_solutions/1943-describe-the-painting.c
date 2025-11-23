/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
typedef struct {
    long long pos;
    long long color;
    int isStart;
} Event;

int compare(const void* a, const void* b) {
    Event* e1 = (Event*)a;
    Event* e2 = (Event*)b;
    if (e1->pos != e2->pos) {
        return (e1->pos > e2->pos) ? 1 : -1;
    }
    return e1->isStart - e2->isStart;
}

long long** splitPainting(int** segments, int segmentsSize, int* segmentsColSize, int* returnSize, int** returnColumnSizes) {
    Event* events = malloc(2 * segmentsSize * sizeof(Event));
    int eventCount = 0;

    for (int i = 0; i < segmentsSize; i++) {
        events[eventCount].pos = segments[i][0];
        events[eventCount].color = segments[i][2];
        events[eventCount].isStart = 1;
        eventCount++;

        events[eventCount].pos = segments[i][1];
        events[eventCount].color = segments[i][2];
        events[eventCount].isStart = 0;
        eventCount++;
    }

    qsort(events, eventCount, sizeof(Event), compare);

    long long** result = malloc(segmentsSize * sizeof(long long*));
    *returnColumnSizes = malloc(segmentsSize * sizeof(int));
    *returnSize = 0;

    long long currentColor = 0;
    long long lastPos = -1;

    for (int i = 0; i < eventCount; i++) {
        Event e = events[i];

        if (lastPos != -1 && lastPos != e.pos && currentColor > 0) {
            result[*returnSize] = malloc(3 * sizeof(long long));
            result[*returnSize][0] = lastPos;
            result[*returnSize][1] = e.pos;
            result[*returnSize][2] = currentColor;
            (*returnColumnSizes)[*returnSize] = 3;
            (*returnSize)++;
        }

        if (e.isStart) {
            currentColor += e.color;
        } else {
            currentColor -= e.color;
        }

        lastPos = e.pos;
    }

    free(events);
    return result;
}