#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <stdio.h> // For snprintf

#define MAX_CUSTOMER_ID 1000001 // Max ID is 10^6, so array size 10^6 + 1
#define MAX_STATION_NAME_LEN 11 // Max 10 chars + null terminator

typedef struct {
    char stationName[MAX_STATION_NAME_LEN];
    int time;
    bool active; // True if customer is currently checked in
} CheckInEntry;

typedef struct AverageNode {
    char startStation[MAX_STATION_NAME_LEN];
    char endStation[MAX_STATION_NAME_LEN];
    int totalTime;
    int count;
    struct AverageNode* next;
} AverageNode;

#define HASH_TABLE_SIZE 100003 // A prime number for hash table size

typedef struct {
    AverageNode* buckets[HASH_TABLE_SIZE];
} AverageTimeHashTable;

typedef struct {
    CheckInEntry checkIns[MAX_CUSTOMER_ID]; // Array for O(1) customer check-in lookup
    AverageTimeHashTable avgTimes;           // Hash table for O(1) average time lookup
} UndergroundSystem;

static unsigned long hash_string(const char *str) {
    unsigned long hash = 5381;
    int c;
    while ((c = *str++)) {
        hash = ((hash << 5) + hash) + c; // hash * 33 + c
    }
    return hash;
}

static unsigned long get_hash_index(const char* startStation, const char* endStation) {
    char combined_key[MAX_STATION_NAME_LEN * 2 + 2]; // "station1_station2\0"
    snprintf(combined_key, sizeof(combined_key), "%s_%s", startStation, endStation);
    return hash_string(combined_key) % HASH_TABLE_SIZE;
}

static AverageNode* find_or_create_average_node(UndergroundSystem* obj, const char* startStation, const char* endStation) {
    unsigned long index = get_hash_index(startStation, endStation);
    AverageNode* current = obj->avgTimes.buckets[index];

    // Search for existing node
    while (current != NULL) {
        if (strcmp(current->startStation, startStation) == 0 && strcmp(current->endStation, endStation) == 0) {
            return current;
        }
        current = current->next;
    }

    // Node not found, create a new one
    AverageNode* newNode = (AverageNode*)malloc(sizeof(AverageNode));
    if (newNode == NULL) {
        // Handle allocation error if necessary
        return NULL;
    }
    snprintf(newNode->startStation, MAX_STATION_NAME_LEN, "%s", startStation);
    snprintf(newNode->endStation, MAX_STATION_NAME_LEN, "%s", endStation);
    newNode->totalTime = 0;
    newNode->count = 0;
    newNode->next = obj->avgTimes.buckets[index]; // Add to the front of the list
    obj->avgTimes.buckets[index] = newNode;

    return newNode;
}

static AverageNode* find_average_node(UndergroundSystem* obj, const char* startStation, const char* endStation) {
    unsigned long index = get_hash_index(startStation, endStation);
    AverageNode* current = obj->avgTimes.buckets[index];

    while (current != NULL) {
        if (strcmp(current->startStation, startStation) == 0 && strcmp(current->endStation, endStation) == 0) {
            return current;
        }
        current = current->next;
    }
    return NULL; // Not found
}

UndergroundSystem* undergroundSystemCreate() {
    UndergroundSystem* obj = (UndergroundSystem*)malloc(sizeof(UndergroundSystem));
    if (obj == NULL) {
        return NULL;
    }

    // Initialize check-in array
    for (int i = 0; i < MAX_CUSTOMER_ID; ++i) {
        obj->checkIns[i].active = false;
    }

    // Initialize average times hash table buckets to NULL
    for (int i = 0; i < HASH_TABLE_SIZE; ++i) {
        obj->avgTimes.buckets[i] = NULL;
    }

    return obj;
}

void undergroundSystemCheckIn(UndergroundSystem* obj, int id, char *stationName, int t) {
    if (id >= 0 && id < MAX_CUSTOMER_ID) {
        snprintf(obj->checkIns[id].stationName, MAX_STATION_NAME_LEN, "%s", stationName);
        obj->checkIns[id].time = t;
        obj->checkIns[id].active = true;
    }
}

void undergroundSystemCheckOut(UndergroundSystem* obj, int id, char *stationName, int t) {
    if (id >= 0 && id < MAX_CUSTOMER_ID && obj->checkIns[id].active) {
        char* checkInStation = obj->checkIns[id].stationName;
        int checkInTime = obj->checkIns[id].time;
        obj->checkIns[id].active = false; // Customer checked out

        int travelTime = t - checkInTime;

        AverageNode* node = find_or_create_average_node(obj, checkInStation, stationName);
        if (node != NULL) {
            node->totalTime += travelTime;
            node->count++;
        }
    }
}

double undergroundSystemGetAverageTime(UndergroundSystem* obj, char *startStation, char *endStation) {
    AverageNode* node = find_average_node(obj, startStation, endStation);
    if (node != NULL && node->count > 0) {
        return (double)node->totalTime / node->count;
    }
    return 0.0; // Should not happen based on problem constraints (always valid calls)
}

void undergroundSystemFree(UndergroundSystem* obj) {
    if (obj == NULL) {
        return;
    }

    // Free all nodes in the average times hash table
    for (int i = 0; i < HASH_TABLE_SIZE; ++i) {
        AverageNode* current = obj->avgTimes.buckets[i];
        while (current != NULL) {
            AverageNode* temp = current;
            current = current->next;
            free(temp);
        }
    }

    free(obj);
}