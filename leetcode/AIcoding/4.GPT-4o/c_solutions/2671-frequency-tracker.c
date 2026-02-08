typedef struct {
    int *count;
    int *freq;
    int size;
} FrequencyTracker;

FrequencyTracker* frequencyTrackerCreate() {
    FrequencyTracker *tracker = (FrequencyTracker *)malloc(sizeof(FrequencyTracker));
    tracker->count = (int *)calloc(100001, sizeof(int));
    tracker->freq = (int *)calloc(100001, sizeof(int));
    tracker->size = 0;
    return tracker;
}

void frequencyTrackerAdd(FrequencyTracker* obj, int number) {
    if (number <= 0 || number > 100000) return;

    int oldFreq = obj->count[number]++;
    if (oldFreq > 0) {
        obj->freq[oldFreq]--;
    }

    obj->freq[oldFreq + 1]++;
}

void frequencyTrackerDeleteOne(FrequencyTracker* obj, int number) {
    if (number <= 0 || number > 100000 || obj->count[number] == 0) return;

    int oldFreq = obj->count[number]--;
    obj->freq[oldFreq]--;
    if (oldFreq > 1) {
        obj->freq[oldFreq - 1]++;
    }
}

bool frequencyTrackerHasFrequency(FrequencyTracker* obj, int frequency) {
    return frequency > 0 && frequency <= 100000 && obj->freq[frequency] > 0;
}

void frequencyTrackerFree(FrequencyTracker* obj) {
    free(obj->count);
    free(obj->freq);
    free(obj);
}