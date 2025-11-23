#include <stdlib.h>
#include <string.h>

typedef struct {
    int timestamp;
    char* value;
} TimeValue;

typedef struct {
    TimeValue* entries;
    int size;
    int capacity;
} TimeValueList;

typedef struct {
    char* key;
    TimeValueList* list;
} KeyTimeValueListPair;

typedef struct HashNode {
    KeyTimeValueListPair pair;
    struct HashNode* next;
} HashNode;

typedef struct {
    HashNode** buckets;
    int num_buckets;
} TimeMap;

unsigned int hash_string(const char* str, int num_buckets) {
    unsigned int hash = 5381;
    int c;
    while ((c = *str++)) {
        hash = ((hash << 5) + hash) + c;
    }
    return hash % num_buckets;
}

void init_time_value_list(TimeValueList* list) {
    list->size = 0;
    list->capacity = 4;
    list->entries = (TimeValue*)malloc(list->capacity * sizeof(TimeValue));
}

void add_time_value(TimeValueList* list, int timestamp, char* value) {
    if (list->size == list->capacity) {
        list->capacity *= 2;
        list->entries = (TimeValue*)realloc(list->entries, list->capacity * sizeof(TimeValue));
    }
    list->entries[list->size].timestamp = timestamp;
    list->entries[list->size].value = strdup(value);
    list->size++;
}

void free_time_value_list(TimeValueList* list) {
    for (int i = 0; i < list->size; i++) {
        free(list->entries[i].value);
    }
    free(list->entries);
}

int find_value_index(TimeValueList* list, int target_timestamp) {
    if (list->size == 0 || list->entries[0].timestamp > target_timestamp) {
        return -1;
    }

    int low = 0;
    int high = list->size - 1;
    int ans_idx = -1;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (list->entries[mid].timestamp <= target_timestamp) {
            ans_idx = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return ans_idx;
}

TimeMap* timeMapCreate() {
    TimeMap* obj = (TimeMap*)malloc(sizeof(TimeMap));
    obj->num_buckets = 20000;
    obj->buckets = (HashNode**)calloc(obj->num_buckets, sizeof(HashNode*));
    return obj;
}

void timeMapSet(TimeMap* obj, char* key, char* value, int timestamp) {
    unsigned int bucket_idx = hash_string(key, obj->num_buckets);

    HashNode* current = obj->buckets[bucket_idx];
    while (current != NULL) {
        if (strcmp(current->pair.key, key) == 0) {
            add_time_value(current->pair.list, timestamp, value);
            return;
        }
        current = current->next;
    }

    HashNode* new_node = (HashNode*)malloc(sizeof(HashNode));
    new_node->pair.key = strdup(key);
    new_node->pair.list = (TimeValueList*)malloc(sizeof(TimeValueList));
    init_time_value_list(new_node->pair.list);
    add_time_value(new_node->pair.list, timestamp, value);

    new_node->next = obj->buckets[bucket_idx];
    obj->buckets[bucket_idx] = new_node;
}

char* timeMapGet(TimeMap* obj, char* key, int timestamp) {
    unsigned int bucket_idx = hash_string(key, obj->num_buckets);

    HashNode* current = obj->buckets[bucket_idx];
    while (current != NULL) {
        if (strcmp(current->pair.key, key) == 0) {
            int idx = find_value_index(current->pair.list, timestamp);
            if (idx != -1) {
                return current->pair.list->entries[idx].value;
            } else {
                return "";
            }
        }
        current = current->next;
    }

    return "";
}

void timeMapFree(TimeMap* obj) {
    for (int i = 0; i < obj->num_buckets; i++) {
        HashNode* current = obj->buckets[i];
        while (current != NULL) {
            HashNode* temp = current;
            free(temp->pair.key);
            free_time_value_list(temp->pair.list);
            free(temp->pair.list);
            current = current->next;
            free(temp);
        }
    }
    free(obj->buckets);
    free(obj);
}