typedef struct {
    int* freq;
    int* freq_count;
    int max_val;
} FrequencyTracker;

FrequencyTracker* frequencyTrackerCreate() {
    FrequencyTracker* obj = (FrequencyTracker*)malloc(sizeof(FrequencyTracker));
    obj->max_val = 100001;
    obj->freq = (int*)calloc(obj->max_val, sizeof(int));
    obj->freq_count = (int*)calloc(obj->max_val, sizeof(int));
    return obj;
}

void frequencyTrackerAdd(FrequencyTracker* obj, int number) {
    if (obj->freq[number] > 0) {
        obj->freq_count[obj->freq[number]]--;
    }
    obj->freq[number]++;
    obj->freq_count[obj->freq[number]]++;
}

void frequencyTrackerDeleteOne(FrequencyTracker* obj, int number) {
    if (obj->freq[number] > 0) {
        obj->freq_count[obj->freq[number]]--;
        obj->freq[number]--;
        obj->freq_count[obj->freq[number]]++;
    }
}

bool frequencyTrackerHasFrequency(FrequencyTracker* obj, int frequency) {
    return frequency > 0 && frequency < obj->max_val && obj->freq_count[frequency] > 0;
}

void frequencyTrackerFree(FrequencyTracker* obj) {
    free(obj->freq);
    free(obj->freq_count);
    free(obj);
}