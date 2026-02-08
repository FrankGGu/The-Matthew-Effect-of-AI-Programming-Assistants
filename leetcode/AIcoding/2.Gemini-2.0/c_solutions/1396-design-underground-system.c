#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    char stationName[21];
    int t;
} CheckInInfo;

typedef struct {
    char startStation[21];
    char endStation[21];
    double totalTime;
    int count;
} TravelTime;

typedef struct {
    CheckInInfo *checkIns;
    int checkInsSize;
    int checkInsCapacity;

    TravelTime *travelTimes;
    int travelTimesSize;
    int travelTimesCapacity;
} UndergroundSystem;

UndergroundSystem* undergroundSystemCreate() {
    UndergroundSystem* obj = (UndergroundSystem*)malloc(sizeof(UndergroundSystem));
    obj->checkInsSize = 0;
    obj->checkInsCapacity = 1000;
    obj->checkIns = (CheckInInfo*)malloc(obj->checkInsCapacity * sizeof(CheckInInfo));

    obj->travelTimesSize = 0;
    obj->travelTimesCapacity = 100;
    obj->travelTimes = (TravelTime*)malloc(obj->travelTimesCapacity * sizeof(TravelTime));

    return obj;
}

void undergroundSystemCheckIn(UndergroundSystem* obj, int id, char * stationName, int t) {
    if (obj->checkInsSize == obj->checkInsCapacity) {
        obj->checkInsCapacity *= 2;
        obj->checkIns = (CheckInInfo*)realloc(obj->checkIns, obj->checkInsCapacity * sizeof(CheckInInfo));
    }

    obj->checkIns[obj->checkInsSize].id = id;
    strcpy(obj->checkIns[obj->checkInsSize].stationName, stationName);
    obj->checkIns[obj->checkInsSize].t = t;
    obj->checkInsSize++;
}

void undergroundSystemCheckOut(UndergroundSystem* obj, int id, char * stationName, int t) {
    int checkInIndex = -1;
    for (int i = 0; i < obj->checkInsSize; i++) {
        if (obj->checkIns[i].id == id) {
            checkInIndex = i;
            break;
        }
    }

    if (checkInIndex == -1) return;

    char startStation[21];
    strcpy(startStation, obj->checkIns[checkInIndex].stationName);
    int startTime = obj->checkIns[checkInIndex].t;

    // Remove the check-in entry
    for (int i = checkInIndex; i < obj->checkInsSize - 1; i++) {
        obj->checkIns[i] = obj->checkIns[i + 1];
    }
    obj->checkInsSize--;

    // Update travel time
    int travelTimeIndex = -1;
    for (int i = 0; i < obj->travelTimesSize; i++) {
        if (strcmp(obj->travelTimes[i].startStation, startStation) == 0 &&
            strcmp(obj->travelTimes[i].endStation, stationName) == 0) {
            travelTimeIndex = i;
            break;
        }
    }

    if (travelTimeIndex == -1) {
        if (obj->travelTimesSize == obj->travelTimesCapacity) {
            obj->travelTimesCapacity *= 2;
            obj->travelTimes = (TravelTime*)realloc(obj->travelTimes, obj->travelTimesCapacity * sizeof(TravelTime));
        }
        strcpy(obj->travelTimes[obj->travelTimesSize].startStation, startStation);
        strcpy(obj->travelTimes[obj->travelTimesSize].endStation, stationName);
        obj->travelTimes[obj->travelTimesSize].totalTime = (double)(t - startTime);
        obj->travelTimes[obj->travelTimesSize].count = 1;
        obj->travelTimesSize++;
    } else {
        obj->travelTimes[travelTimeIndex].totalTime += (double)(t - startTime);
        obj->travelTimes[travelTimeIndex].count++;
    }
}

double undergroundSystemGetAverageTime(UndergroundSystem* obj, char * startStation, char * endStation) {
    for (int i = 0; i < obj->travelTimesSize; i++) {
        if (strcmp(obj->travelTimes[i].startStation, startStation) == 0 &&
            strcmp(obj->travelTimes[i].endStation, endStation) == 0) {
            return obj->travelTimes[i].totalTime / obj->travelTimes[i].count;
        }
    }
    return 0.0;
}

void undergroundSystemFree(UndergroundSystem* obj) {
    free(obj->checkIns);
    free(obj->travelTimes);
    free(obj);
}