typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    Point* points;
    int size;
    int capacity;
} HashSet;

void initHashSet(HashSet* set) {
    set->capacity = 1000;
    set->size = 0;
    set->points = (Point*)malloc(set->capacity * sizeof(Point));
}

void freeHashSet(HashSet* set) {
    free(set->points);
}

int contains(HashSet* set, Point p) {
    for (int i = 0; i < set->size; i++) {
        if (set->points[i].x == p.x && set->points[i].y == p.y) {
            return 1;
        }
    }
    return 0;
}

void add(HashSet* set, Point p) {
    if (set->size == set->capacity) {
        set->capacity *= 2;
        set->points = (Point*)realloc(set->points, set->capacity * sizeof(Point));
    }
    set->points[set->size++] = p;
}

bool isPathCrossing(char* path) {
    HashSet visited;
    initHashSet(&visited);

    Point current = {0, 0};
    add(&visited, current);

    for (int i = 0; path[i] != '\0'; i++) {
        switch (path[i]) {
            case 'N': current.y++; break;
            case 'S': current.y--; break;
            case 'E': current.x++; break;
            case 'W': current.x--; break;
        }

        if (contains(&visited, current)) {
            freeHashSet(&visited);
            return true;
        }

        add(&visited, current);
    }

    freeHashSet(&visited);
    return false;
}