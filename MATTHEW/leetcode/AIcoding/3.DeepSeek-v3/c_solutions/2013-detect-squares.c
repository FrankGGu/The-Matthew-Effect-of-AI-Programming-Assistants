typedef struct {
    int key;
    int count;
    UT_hash_handle hh;
} PointCount;

typedef struct {
    PointCount* points;
} DetectSquares;

DetectSquares* detectSquaresCreate() {
    DetectSquares* obj = (DetectSquares*)malloc(sizeof(DetectSquares));
    obj->points = NULL;
    return obj;
}

void detectSquaresAdd(DetectSquares* obj, int* point, int pointSize) {
    int key = point[0] * 100000 + point[1];
    PointCount* entry;
    HASH_FIND_INT(obj->points, &key, entry);
    if (entry == NULL) {
        entry = (PointCount*)malloc(sizeof(PointCount));
        entry->key = key;
        entry->count = 1;
        HASH_ADD_INT(obj->points, key, entry);
    } else {
        entry->count++;
    }
}

int detectSquaresCount(DetectSquares* obj, int* point, int pointSize) {
    int x1 = point[0], y1 = point[1];
    int count = 0;

    PointCount *curr, *tmp;
    HASH_ITER(hh, obj->points, curr, tmp) {
        int x3 = curr->key / 100000;
        int y3 = curr->key % 100000;

        if (x1 == x3 || y1 == y3 || abs(x1 - x3) != abs(y1 - y3)) {
            continue;
        }

        int key2 = x1 * 100000 + y3;
        int key4 = x3 * 100000 + y1;

        PointCount* p2;
        PointCount* p4;

        HASH_FIND_INT(obj->points, &key2, p2);
        HASH_FIND_INT(obj->points, &key4, p4);

        if (p2 != NULL && p4 != NULL) {
            count += curr->count * p2->count * p4->count;
        }
    }

    return count;
}

void detectSquaresFree(DetectSquares* obj) {
    PointCount *curr, *tmp;
    HASH_ITER(hh, obj->points, curr, tmp) {
        HASH_DEL(obj->points, curr);
        free(curr);
    }
    free(obj);
}