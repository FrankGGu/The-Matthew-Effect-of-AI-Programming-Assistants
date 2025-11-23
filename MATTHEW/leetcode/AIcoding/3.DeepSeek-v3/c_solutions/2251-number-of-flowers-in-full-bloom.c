typedef struct {
    int time;
    int type;
    int idx;
} Event;

int cmp(const void* a, const void* b) {
    Event* e1 = (Event*)a;
    Event* e2 = (Event*)b;
    if (e1->time == e2->time) {
        return e1->type - e2->type;
    }
    return e1->time - e2->time;
}

int* fullBloomFlowers(int** flowers, int flowersSize, int* flowersColSize, int* people, int peopleSize, int* returnSize) {
    *returnSize = peopleSize;
    int* result = (int*)malloc(peopleSize * sizeof(int));

    Event* events = (Event*)malloc((flowersSize * 2 + peopleSize) * sizeof(Event));
    int eventsCount = 0;

    for (int i = 0; i < flowersSize; i++) {
        events[eventsCount].time = flowers[i][0];
        events[eventsCount].type = 1;
        events[eventsCount].idx = -1;
        eventsCount++;

        events[eventsCount].time = flowers[i][1] + 1;
        events[eventsCount].type = -1;
        events[eventsCount].idx = -1;
        eventsCount++;
    }

    for (int i = 0; i < peopleSize; i++) {
        events[eventsCount].time = people[i];
        events[eventsCount].type = 0;
        events[eventsCount].idx = i;
        eventsCount++;
    }

    qsort(events, eventsCount, sizeof(Event), cmp);

    int bloomCount = 0;
    for (int i = 0; i < eventsCount; i++) {
        if (events[i].type == 1) {
            bloomCount++;
        } else if (events[i].type == -1) {
            bloomCount--;
        } else {
            result[events[i].idx] = bloomCount;
        }
    }

    free(events);
    return result;
}