#include <stdlib.h>
#include <string.h> // Required for memset

#define MAX_VAL 100001

typedef struct {
    int num_freq[MAX_VAL];    // Stores frequency of each number (number -> frequency)
    int freq_count[MAX_VAL];  // Stores count of numbers having a certain frequency (frequency -> count)
} FrequencyTracker;

FrequencyTracker* frequencyTrackerCreate() {
    FrequencyTracker* obj = (FrequencyTracker*)malloc(sizeof(FrequencyTracker));
    if (obj == NULL) {
        return NULL; // Handle allocation failure
    }
    memset(obj->num_freq, 0, sizeof(obj->num_freq));
    memset(obj->freq_count, 0, sizeof(obj->freq_count));
    return obj;
}

void frequencyTrackerAdd(FrequencyTracker* obj, int number) {
    int old_freq = obj->num_freq[number];
    if (old_freq > 0) {
        obj->freq_count[old_freq]--;
    }
    obj->num_freq[number]++;
    int new_freq = obj->num_freq[number];
    obj->freq_count[new_freq]++;
}

void frequencyTrackerDeleteOne(FrequencyTracker* obj, int number) {
    int old_freq = obj->num_freq[number];
    if (old_freq > 0) {
        obj->freq_count[old_freq]--;
        obj->num_freq[number]--;
        int new_freq = obj->num_freq[number];
        if (new_freq > 0) {
            obj->freq_count[new_freq]++;
        }
    }
}

bool frequencyTrackerHasFrequency(FrequencyTracker* obj, int frequency) {
    return obj->freq_count[frequency] > 0;
}

void frequencyTrackerFree(FrequencyTracker* obj) {
    free(obj);
}