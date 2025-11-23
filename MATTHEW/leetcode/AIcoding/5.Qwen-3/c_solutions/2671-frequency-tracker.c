#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* freq;
    int max_freq;
} FrequencyTracker;

FrequencyTracker* frequencyTrackerCreate() {
    FrequencyTracker* obj = (FrequencyTracker*)malloc(sizeof(FrequencyTracker));
    obj->freq = (int*)calloc(10001, sizeof(int));
    obj->max_freq = 0;
    return obj;
}

void frequencyTrackerAdd(FrequencyTracker* obj, int number) {
    if (obj->freq[number] > 0) {
        obj->freq[obj->freq[number]]--;
    }
    obj->freq[number]++;
    if (obj->freq[number] > obj->max_freq) {
        obj->max_freq = obj->freq[number];
    }
}

void frequencyTrackerDelete(FrequencyTracker* obj, int number) {
    if (obj->freq[number] > 0) {
        obj->freq[obj->freq[number]]--;
        obj->freq[number]--;
        if (obj->freq[number] == 0) {
            obj->max_freq = 0;
            for (int i = 1; i <= 10000; i++) {
                if (obj->freq[i] > obj->max_freq) {
                    obj->max_freq = obj->freq[i];
                }
            }
        }
    }
}

bool frequencyTrackerHasFrequency(FrequencyTracker* obj, int frequency) {
    return obj->max_freq >= frequency;
}

void frequencyTrackerFree(FrequencyTracker* obj) {
    free(obj->freq);
    free(obj);
}