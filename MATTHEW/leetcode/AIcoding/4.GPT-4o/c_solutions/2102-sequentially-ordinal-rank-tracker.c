typedef struct {
    int *rank;
    int size;
} RankTracker;

RankTracker* rankTrackerCreate(int n) {
    RankTracker *tracker = (RankTracker *)malloc(sizeof(RankTracker));
    tracker->rank = (int *)calloc(n + 1, sizeof(int));
    tracker->size = n;
    return tracker;
}

void rankTrackerTrack(RankTracker* obj, int number) {
    for (int i = number; i <= obj->size; i++) {
        obj->rank[i]++;
    }
}

int rankTrackerGetRank(RankTracker* obj, int number) {
    return obj->rank[number];
}

void rankTrackerFree(RankTracker* obj) {
    free(obj->rank);
    free(obj);
}