#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* startStation;
    char* endStation;
    int totalTime;
    int count;
} Journey;

typedef struct {
    Journey* journeys;
    int journeyCount;
} Station;

typedef struct {
    Station* stations;
    int stationCount;
} UndergroundSystem;

UndergroundSystem* undergroundSystemCreate() {
    UndergroundSystem* us = (UndergroundSystem*)malloc(sizeof(UndergroundSystem));
    us->stations = (Station*)malloc(1000 * sizeof(Station));
    us->stationCount = 0;
    return us;
}

void undergroundSystemCheckIn(UndergroundSystem* obj, int id, char* stationName, int t) {
    char* station = (char*)malloc((strlen(stationName) + 1) * sizeof(char));
    strcpy(station, stationName);
    Station* s = NULL;
    for (int i = 0; i < obj->stationCount; i++) {
        if (strcmp(obj->stations[i].journeys[0].startStation, station) == 0) {
            s = &obj->stations[i];
            break;
        }
    }
    if (s == NULL) {
        s = &obj->stations[obj->stationCount++];
        s->journeys = (Journey*)malloc(100 * sizeof(Journey));
        s->journeyCount = 0;
        s->journeys[0].startStation = station;
    }
    s->journeys[s->journeyCount].startStation = station;
    s->journeys[s->journeyCount].totalTime = t;
    s->journeys[s->journeyCount].count = 1;
    s->journeyCount++;
}

void undergroundSystemCheckOut(UndergroundSystem* obj, int id, char* stationName, int t) {
    for (int i = 0; i < obj->stationCount; i++) {
        for (int j = 0; j < obj->stations[i].journeyCount; j++) {
            if (strcmp(obj->stations[i].journeys[j].startStation, stationName) == 0) {
                obj->stations[i].journeys[j].totalTime += t - obj->stations[i].journeys[j].totalTime;
                obj->stations[i].journeys[j].count++;
                return;
            }
        }
    }
}

double undergroundSystemGetAverageTime(UndergroundSystem* obj, char* startStation, char* endStation) {
    for (int i = 0; i < obj->stationCount; i++) {
        for (int j = 0; j < obj->stations[i].journeyCount; j++) {
            if (strcmp(obj->stations[i].journeys[j].startStation, startStation) == 0) {
                return (double)obj->stations[i].journeys[j].totalTime / obj->stations[i].journeys[j].count;
            }
        }
    }
    return 0.0;
}

void undergroundSystemFree(UndergroundSystem* obj) {
    for (int i = 0; i < obj->stationCount; i++) {
        free(obj->stations[i].journeys[0].startStation);
        free(obj->stations[i].journeys);
    }
    free(obj->stations);
    free(obj);
}