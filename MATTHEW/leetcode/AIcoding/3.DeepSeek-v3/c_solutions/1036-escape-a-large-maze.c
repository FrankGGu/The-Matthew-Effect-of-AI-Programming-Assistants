#include <stdlib.h>
#include <stdbool.h>

#define HASH_SIZE 20000

typedef struct {
    int x;
    int y;
} Point;

typedef struct Node {
    Point point;
    struct Node* next;
} Node;

typedef struct {
    Node* buckets[HASH_SIZE];
} HashSet;

int hash(Point p) {
    return (p.x * 31 + p.y) % HASH_SIZE;
}

void hashSetInit(HashSet* set) {
    for (int i = 0; i < HASH_SIZE; i++) {
        set->buckets[i] = NULL;
    }
}

bool hashSetContains(HashSet* set, Point p) {
    int idx = hash(p);
    Node* node = set->buckets[idx];
    while (node != NULL) {
        if (node->point.x == p.x && node->point.y == p.y) {
            return true;
        }
        node = node->next;
    }
    return false;
}

void hashSetAdd(HashSet* set, Point p) {
    if (hashSetContains(set, p)) return;
    int idx = hash(p);
    Node* node = malloc(sizeof(Node));
    node->point = p;
    node->next = set->buckets[idx];
    set->buckets[idx] = node;
}

void hashSetFree(HashSet* set) {
    for (int i = 0; i < HASH_SIZE; i++) {
        Node* node = set->buckets[i];
        while (node != NULL) {
            Node* temp = node;
            node = node->next;
            free(temp);
        }
    }
}

const int dirs[4][2] = {{0,1}, {1,0}, {0,-1}, {-1,0}};

bool dfs(Point source, Point target, Point* blocked, int blockedSize, HashSet* visited) {
    if (source.x == target.x && source.y == target.y) {
        return true;
    }

    if (abs(source.x - target.x) + abs(source.y - target.y) > 200) {
        return true;
    }

    hashSetAdd(visited, source);

    for (int i = 0; i < 4; i++) {
        int nx = source.x + dirs[i][0];
        int ny = source.y + dirs[i][1];
        Point next = {nx, ny};

        if (nx < 0 || ny < 0 || nx >= 1000000 || ny >= 1000000) {
            continue;
        }

        if (hashSetContains(visited, next)) {
            continue;
        }

        bool isBlocked = false;
        for (int j = 0; j < blockedSize; j++) {
            if (nx == blocked[j].x && ny == blocked[j].y) {
                isBlocked = true;
                break;
            }
        }
        if (isBlocked) {
            continue;
        }

        if (dfs(next, target, blocked, blockedSize, visited)) {
            return true;
        }
    }

    return false;
}

bool isEscapePossible(int** blocked, int blockedSize, int* blockedColSize, int* source, int sourceSize, int* target, int targetSize) {
    if (blockedSize == 0) {
        return true;
    }

    Point src = {source[0], source[1]};
    Point tar = {target[0], target[1]};

    Point* blockedPoints = malloc(blockedSize * sizeof(Point));
    for (int i = 0; i < blockedSize; i++) {
        blockedPoints[i].x = blocked[i][0];
        blockedPoints[i].y = blocked[i][1];
    }

    HashSet visited1, visited2;
    hashSetInit(&visited1);
    hashSetInit(&visited2);

    bool result = dfs(src, tar, blockedPoints, blockedSize, &visited1) && 
                  dfs(tar, src, blockedPoints, blockedSize, &visited2);

    hashSetFree(&visited1);
    hashSetFree(&visited2);
    free(blockedPoints);

    return result;
}