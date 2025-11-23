#include <stdlib.h>

struct Event {
    int x;
    int h;
    int type; // 1 for start, -1 for end
};

int cmp(const void *a, const void *b) {
    struct Event *e1 = (struct Event *)a;
    struct Event *e2 = (struct Event *)b;
    if (e1->x != e2->x) return e1->x - e2->x;
    return e2->h - e1->h; // Higher height first if same x
}

int** getSkyline(int** buildings, int buildingsSize, int* buildingsColSize, int* returnSize, int** returnColumnSizes) {
    struct Event events[2 * buildingsSize];
    for (int i = 0; i < buildingsSize; i++) {
        events[2 * i] = (struct Event){buildings[i][0], buildings[i][2], 1}; // start
        events[2 * i + 1] = (struct Event){buildings[i][1], buildings[i][2], -1}; // end
    }

    qsort(events, 2 * buildingsSize, sizeof(struct Event), cmp);

    int** result = (int**)malloc(sizeof(int*) * (2 * buildingsSize));
    *returnColumnSizes = (int*)malloc(sizeof(int) * (2 * buildingsSize));
    int size = 0;

    int heights[10000] = {0};
    int maxHeight = 0;
    for (int i = 0; i < 2 * buildingsSize; i++) {
        if (events[i].type == 1) {
            heights[events[i].h]++;
            if (events[i].h > maxHeight) maxHeight = events[i].h;
        } else {
            heights[events[i].h]--;
            if (heights[events[i].h] == 0 && events[i].h == maxHeight) {
                maxHeight--;
            }
        }

        int currentMaxHeight = 0;
        for (int j = 0; j <= 10000; j++) {
            if (heights[j] > 0) {
                currentMaxHeight = j;
            }
        }

        if (currentMaxHeight != (size == 0 ? 0 : result[size - 1][1])) {
            result[size] = (int*)malloc(sizeof(int) * 2);
            result[size][0] = events[i].x;
            result[size][1] = currentMaxHeight;
            (*returnColumnSizes)[size] = 2;
            size++;
        }
    }

    *returnSize = size;
    return result;
}