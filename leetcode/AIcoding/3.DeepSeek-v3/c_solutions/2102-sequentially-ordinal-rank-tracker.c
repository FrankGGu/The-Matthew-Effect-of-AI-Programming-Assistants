typedef struct {
    char name[21];
    int score;
} Location;

typedef struct {
    Location* locations;
    int size;
    int capacity;
} SORTracker;

SORTracker* sORTrackerCreate() {
    SORTracker* obj = (SORTracker*)malloc(sizeof(SORTracker));
    obj->size = 0;
    obj->capacity = 10000;
    obj->locations = (Location*)malloc(obj->capacity * sizeof(Location));
    return obj;
}

int compare(const void* a, const void* b) {
    Location* locA = (Location*)a;
    Location* locB = (Location*)b;
    if (locA->score != locB->score) {
        return locB->score - locA->score;
    }
    return strcmp(locA->name, locB->name);
}

void sORTrackerAdd(SORTracker* obj, char* name, int score) {
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->locations = (Location*)realloc(obj->locations, obj->capacity * sizeof(Location));
    }
    strcpy(obj->locations[obj->size].name, name);
    obj->locations[obj->size].score = score;
    obj->size++;
    qsort(obj->locations, obj->size, sizeof(Location), compare);
}

char* sORTrackerGet(SORTracker* obj) {
    static int callCount = 0;
    return obj->locations[callCount++].name;
}

void sORTrackerFree(SORTracker* obj) {
    free(obj->locations);
    free(obj);
}