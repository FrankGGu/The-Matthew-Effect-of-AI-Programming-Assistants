#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* num_freq;
    int* freq_count;
} FrequencyTracker;

FrequencyTracker* frequencyTrackerCreate() {
    FrequencyTracker* obj = (FrequencyTracker*)malloc(sizeof(FrequencyTracker));
    obj->num_freq = (int*)calloc(100001, sizeof(int));
    obj->freq_count = (int*)calloc(100001, sizeof(int));
    return obj;
}

void frequencyTrackerAdd(FrequencyTracker* obj, int number) {
    int freq = obj->num_freq[number];
    if (freq > 0) {
        obj->freq_count[freq]--;
    }
    obj->num_freq[number]++;
    obj->freq_count[obj->num_freq[number]]++;
}

void frequencyTrackerDeleteOne(FrequencyTracker* obj, int number) {
    if (obj->num_freq[number] > 0) {
        int freq = obj->num_freq[number];
        obj->freq_count[freq]--;
        obj->num_freq[number]--;
        obj->freq_count[obj->num_freq[number]]++;
    }
}

bool frequencyTrackerHasFrequency(FrequencyTracker* obj, int frequency) {
    return obj->freq_count[frequency] > 0;
}

void frequencyTrackerFree(FrequencyTracker* obj) {
    free(obj->num_freq);
    free(obj->freq_count);
    free(obj);
}