typedef struct {
    int id;
    char* stationName;
    int t;
} CheckInInfo;

typedef struct {
    char* startStation;
    char* endStation;
    int totalTime;
    int count;
} TravelInfo;

typedef struct {
    CheckInInfo* checkIns;
    int checkInSize;
    int checkInCapacity;

    TravelInfo* travels;
    int travelSize;
    int travelCapacity;
} UndergroundSystem;

UndergroundSystem* undergroundSystemCreate() {
    UndergroundSystem* obj = (UndergroundSystem*)malloc(sizeof(UndergroundSystem));
    obj->checkIns = (CheckInInfo*)malloc(sizeof(CheckInInfo) * 10000);
    obj->checkInSize = 0;
    obj->checkInCapacity = 10000;

    obj->travels = (TravelInfo*)malloc(sizeof(TravelInfo) * 10000);
    obj->travelSize = 0;
    obj->travelCapacity = 10000;
    return obj;
}

void undergroundSystemCheckIn(UndergroundSystem* obj, int id, char* stationName, int t) {
    for (int i = 0; i < obj->checkInSize; i++) {
        if (obj->checkIns[i].id == id) {
            obj->checkIns[i].stationName = stationName;
            obj->checkIns[i].t = t;
            return;
        }
    }

    if (obj->checkInSize == obj->checkInCapacity) {
        obj->checkInCapacity *= 2;
        obj->checkIns = (CheckInInfo*)realloc(obj->checkIns, sizeof(CheckInInfo) * obj->checkInCapacity);
    }

    obj->checkIns[obj->checkInSize].id = id;
    obj->checkIns[obj->checkInSize].stationName = stationName;
    obj->checkIns[obj->checkInSize].t = t;
    obj->checkInSize++;
}

void undergroundSystemCheckOut(UndergroundSystem* obj, int id, char* stationName, int t) {
    char* startStation = NULL;
    int startTime = 0;

    for (int i = 0; i < obj->checkInSize; i++) {
        if (obj->checkIns[i].id == id) {
            startStation = obj->checkIns[i].stationName;
            startTime = obj->checkIns[i].t;
            break;
        }
    }

    for (int i = 0; i < obj->travelSize; i++) {
        if (strcmp(obj->travels[i].startStation, startStation) == 0 && 
            strcmp(obj->travels[i].endStation, stationName) == 0) {
            obj->travels[i].totalTime += (t - startTime);
            obj->travels[i].count++;
            return;
        }
    }

    if (obj->travelSize == obj->travelCapacity) {
        obj->travelCapacity *= 2;
        obj->travels = (TravelInfo*)realloc(obj->travels, sizeof(TravelInfo) * obj->travelCapacity);
    }

    obj->travels[obj->travelSize].startStation = startStation;
    obj->travels[obj->travelSize].endStation = stationName;
    obj->travels[obj->travelSize].totalTime = t - startTime;
    obj->travels[obj->travelSize].count = 1;
    obj->travelSize++;
}

double undergroundSystemGetAverageTime(UndergroundSystem* obj, char* startStation, char* endStation) {
    for (int i = 0; i < obj->travelSize; i++) {
        if (strcmp(obj->travels[i].startStation, startStation) == 0 && 
            strcmp(obj->travels[i].endStation, endStation) == 0) {
            return (double)obj->travels[i].totalTime / obj->travels[i].count;
        }
    }
    return 0.0;
}

void undergroundSystemFree(UndergroundSystem* obj) {
    free(obj->checkIns);
    free(obj->travels);
    free(obj);
}