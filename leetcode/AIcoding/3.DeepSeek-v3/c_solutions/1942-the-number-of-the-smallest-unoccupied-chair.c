typedef struct {
    int time;
    int type;
    int index;
} Event;

int cmp(const void* a, const void* b) {
    Event* e1 = (Event*)a;
    Event* e2 = (Event*)b;
    if (e1->time == e2->time) {
        return e2->type - e1->type;
    }
    return e1->time - e2->time;
}

int smallestChair(int** times, int timesSize, int* timesColSize, int targetFriend) {
    Event* events = malloc(2 * timesSize * sizeof(Event));
    for (int i = 0; i < timesSize; i++) {
        events[2 * i] = (Event){times[i][0], 1, i};
        events[2 * i + 1] = (Event){times[i][1], -1, i};
    }

    qsort(events, 2 * timesSize, sizeof(Event), cmp);

    int* chairs = calloc(timesSize, sizeof(int));
    int* friendChair = calloc(timesSize, sizeof(int));

    for (int i = 0; i < 2 * timesSize; i++) {
        Event e = events[i];
        if (e.type == 1) {
            for (int j = 0; j < timesSize; j++) {
                if (chairs[j] == 0) {
                    chairs[j] = 1;
                    friendChair[e.index] = j;
                    if (e.index == targetFriend) {
                        free(events);
                        free(chairs);
                        free(friendChair);
                        return j;
                    }
                    break;
                }
            }
        } else {
            chairs[friendChair[e.index]] = 0;
        }
    }

    free(events);
    free(chairs);
    free(friendChair);
    return -1;
}