#include <stdlib.h>
#include <string.h>

#define HASH_BUCKETS 10000
#define INITIAL_TIMESTAMPS_CAPACITY 10

typedef struct {
    int* data;
    int size;
    int capacity;
    int sorted_until_idx; // Index up to which the array is sorted. -1 if unsorted.
} TimestampList;

typedef struct TweetEntry {
    char* tweetName;
    TimestampList timestamps;
    struct TweetEntry* next;
} TweetEntry;

typedef struct {
    TweetEntry** buckets;
} TweetCounts;

static unsigned int hash_string(const char* s) {
    unsigned int hash = 5381;
    int c;
    while ((c = *s++)) {
        hash = ((hash << 5) + hash) + c;
    }
    return hash % HASH_BUCKETS;
}

static TimestampList create_timestamp_list() {
    TimestampList list;
    list.data = (int*)malloc(sizeof(int) * INITIAL_TIMESTAMPS_CAPACITY);
    list.size = 0;
    list.capacity = INITIAL_TIMESTAMPS_CAPACITY;
    list.sorted_until_idx = 0; // An empty list is considered sorted
    return list;
}

static void add_timestamp(TimestampList* list, int timestamp) {
    if (list->size == list->capacity) {
        list->capacity *= 2;
        list->data = (int*)realloc(list->data, sizeof(int) * list->capacity);
    }
    list->data[list->size++] = timestamp;
    // If the new timestamp is smaller than the previous one, the list is no longer fully sorted.
    if (list->size > 1 && timestamp < list->data[list->size - 2]) {
        list->sorted_until_idx = -1; // Mark as completely unsorted
    } else if (list->sorted_until_idx != -1) {
        list->sorted_until_idx = list->size; // Still sorted up to this point
    }
}

static void free_timestamp_list(TimestampList* list) {
    free(list->data);
    list->data = NULL;
    list->size = 0;
    list->capacity = 0;
}

static TweetEntry* find_entry(TweetCounts* obj, const char* tweetName) {
    unsigned int index = hash_string(tweetName);
    TweetEntry* current = obj->buckets[index];
    while (current != NULL) {
        if (strcmp(current->tweetName, tweetName) == 0) {
            return current;
        }
        current = current->next;
    }
    return NULL;
}

static TweetEntry* create_entry(const char* tweetName) {
    TweetEntry* newEntry = (TweetEntry*)malloc(sizeof(TweetEntry));
    newEntry->tweetName = strdup(tweetName);
    newEntry->timestamps = create_timestamp_list();
    newEntry->next = NULL;
    return newEntry;
}

static int compare_timestamps(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

TweetCounts* tweetCountsCreate() {
    TweetCounts* obj = (TweetCounts*)malloc(sizeof(TweetCounts));
    obj->buckets = (TweetEntry**)calloc(HASH_BUCKETS, sizeof(TweetEntry*));
    return obj;
}

void tweetCountsRecordTweet(TweetCounts* obj, char* tweetName, int timestamp) {
    TweetEntry* entry = find_entry(obj, tweetName);

    if (entry == NULL) {
        entry = create_entry(tweetName);
        unsigned int index = hash_string(tweetName);
        entry->next = obj->buckets[index];
        obj->buckets[index] = entry;
    }
    add_timestamp(&entry->timestamps, timestamp);
}

int* tweetCountsGetTweetCounts(TweetCounts* obj, char* freq, char* tweetName, int startTime, int endTime, int* retSize) {
    TweetEntry* entry = find_entry(obj, tweetName);

    if (entry == NULL || entry->timestamps.size == 0) {
        *retSize = 0;
        return NULL;
    }

    if (entry->timestamps.sorted_until_idx != entry->timestamps.size) {
        qsort(entry->timestamps.data, entry->timestamps.size, sizeof(int), compare_timestamps);
        entry->timestamps.sorted_until_idx = entry->timestamps.size;
    }

    int delta;
    if (strcmp(freq, "minute") == 0) {
        delta = 60;
    } else if (strcmp(freq, "hour") == 0) {
        delta = 3600;
    } else { // "day"
        delta = 86400;
    }

    int num_intervals = (endTime - startTime) / delta + 1;
    int* result = (int*)calloc(num_intervals, sizeof(int));
    if (result == NULL) {
        *retSize = 0;
        return NULL;
    }

    for (int i = 0; i < entry->timestamps.size; ++i) {
        int timestamp = entry->timestamps.data[i];
        if (timestamp >= startTime && timestamp <= endTime) {
            int idx = (timestamp - startTime) / delta;
            if (idx >= 0 && idx < num_intervals) {
                result[idx]++;
            }
        }
    }

    *retSize = num_intervals;
    return result;
}

void tweetCountsFree(TweetCounts* obj) {
    if (obj == NULL) return;

    for (int i = 0; i < HASH_BUCKETS; ++i) {
        TweetEntry* current = obj->buckets[i];
        while (current != NULL) {
            TweetEntry* next = current->next;
            free(current->tweetName);
            free_timestamp_list(&current->timestamps);
            free(current);
            current = next;
        }
    }
    free(obj->buckets);
    free(obj);
}