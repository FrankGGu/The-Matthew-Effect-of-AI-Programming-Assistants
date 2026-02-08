#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* startStation;
    char* endStation;
    int time;
} Trip;

typedef struct {
    char* stationName;
    int time;
} CheckIn;

typedef struct {
    char* key;
    int total;
    int count;
} Average;

typedef struct {
    CheckIn* checkIns;
    int size;
    int capacity;
} CheckInMap;

typedef struct {
    Average* averages;
    int size;
    int capacity;
} AverageMap;

typedef struct {
    CheckInMap checkInMap;
    AverageMap averageMap;
} UndergroundSystem;

UndergroundSystem* undergroundSystemCreate() {
    UndergroundSystem* obj = (UndergroundSystem*)malloc(sizeof(UndergroundSystem));
    obj->checkInMap.checkIns = (CheckIn*)malloc(10 * sizeof(CheckIn));
    obj->checkInMap.size = 0;
    obj->checkInMap.capacity = 10;
    obj->averageMap.averages = (Average*)malloc(10 * sizeof(Average));
    obj->averageMap.size = 0;
    obj->averageMap.capacity = 10;
    return obj;
}

void undergroundSystemCheckIn(UndergroundSystem* obj, char* id, char* stationName, int t) {
    if (obj->checkInMap.size >= obj->checkInMap.capacity) {
        obj->checkInMap.capacity *= 2;
        obj->checkInMap.checkIns = (CheckIn*)realloc(obj->checkInMap.checkIns, obj->checkInMap.capacity * sizeof(CheckIn));
    }
    CheckIn* checkIn = &obj->checkInMap.checkIns[obj->checkInMap.size];
    checkIn->stationName = strdup(stationName);
    checkIn->time = t;
    obj->checkInMap.size++;
}

void undergroundSystemCheckOut(UndergroundSystem* obj, char* id, char* stationName, int t) {
    for (int i = 0; i < obj->checkInMap.size; i++) {
        if (strcmp(obj->checkInMap.checkIns[i].stationName, stationName) == 0) {
            char* key = (char*)malloc(100 * sizeof(char));
            sprintf(key, "%s,%s", obj->checkInMap.checkIns[i].stationName, stationName);
            int duration = t - obj->checkInMap.checkIns[i].time;
            int found = 0;
            for (int j = 0; j < obj->averageMap.size; j++) {
                if (strcmp(obj->averageMap.averages[j].key, key) == 0) {
                    obj->averageMap.averages[j].total += duration;
                    obj->averageMap.averages[j].count++;
                    found = 1;
                    break;
                }
            }
            if (!found) {
                if (obj->averageMap.size >= obj->averageMap.capacity) {
                    obj->averageMap.capacity *= 2;
                    obj->averageMap.averages = (Average*)realloc(obj->averageMap.averages, obj->averageMap.capacity * sizeof(Average));
                }
                Average* avg = &obj->averageMap.averages[obj->averageMap.size];
                avg->key = strdup(key);
                avg->total = duration;
                avg->count = 1;
                obj->averageMap.size++;
            }
            free(key);
            break;
        }
    }
}

double undergroundSystemGetAverageTime(UndergroundSystem* obj, char* startStation, char* endStation) {
    char* key = (char*)malloc(100 * sizeof(char));
    sprintf(key, "%s,%s", startStation, endStation);
    for (int i = 0; i < obj->averageMap.size; i++) {
        if (strcmp(obj->averageMap.averages[i].key, key) == 0) {
            free(key);
            return (double)obj->averageMap.averages[i].total / obj->averageMap.averages[i].count;
        }
    }
    free(key);
    return 0.0;
}

void undergroundSystemFree(UndergroundSystem* obj) {
    for (int i = 0; i < obj->checkInMap.size; i++) {
        free(obj->checkInMap.checkIns[i].stationName);
    }
    free(obj->checkInMap.checkIns);
    for (int i = 0; i < obj->averageMap.size; i++) {
        free(obj->averageMap.averages[i].key);
    }
    free(obj->averageMap.averages);
    free(obj);
}