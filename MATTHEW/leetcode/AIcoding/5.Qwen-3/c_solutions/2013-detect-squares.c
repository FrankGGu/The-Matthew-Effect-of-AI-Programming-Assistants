#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    int x;
    int y;
    int count;
} PointCount;

typedef struct {
    int size;
    PointCount *points;
} PointList;

typedef struct {
    int x;
    int y;
    int count;
} PointMap;

typedef struct {
    int size;
    PointMap *map;
} PointMapList;

PointList* create_point_list() {
    PointList *list = (PointList*)malloc(sizeof(PointList));
    list->size = 0;
    list->points = NULL;
    return list;
}

void add_point(PointList *list, int x, int y) {
    list->size++;
    list->points = (PointCount*)realloc(list->points, list->size * sizeof(PointCount));
    list->points[list->size - 1].x = x;
    list->points[list->size - 1].y = y;
    list->points[list->size - 1].count = 1;
}

void increment_count(PointList *list, int x, int y) {
    for (int i = 0; i < list->size; i++) {
        if (list->points[i].x == x && list->points[i].y == y) {
            list->points[i].count++;
            return;
        }
    }
    add_point(list, x, y);
}

int get_count(PointList *list, int x, int y) {
    for (int i = 0; i < list->size; i++) {
        if (list->points[i].x == x && list->points[i].y == y) {
            return list->points[i].count;
        }
    }
    return 0;
}

PointMapList* create_point_map_list() {
    PointMapList *list = (PointMapList*)malloc(sizeof(PointMapList));
    list->size = 0;
    list->map = NULL;
    return list;
}

void add_point_map(PointMapList *list, int x, int y) {
    list->size++;
    list->map = (PointMap*)realloc(list->map, list->size * sizeof(PointMap));
    list->map[list->size - 1].x = x;
    list->map[list->size - 1].y = y;
    list->map[list->size - 1].count = 1;
}

void increment_count_map(PointMapList *list, int x, int y) {
    for (int i = 0; i < list->size; i++) {
        if (list->map[i].x == x && list->map[i].y == y) {
            list->map[i].count++;
            return;
        }
    }
    add_point_map(list, x, y);
}

int get_count_map(PointMapList *list, int x, int y) {
    for (int i = 0; i < list->size; i++) {
        if (list->map[i].x == x && list->map[i].y == y) {
            return list->map[i].count;
        }
    }
    return 0;
}

int** detectSquares(int** points, int pointsSize, int* pointsColSize, int** event, int eventSize, int* eventColSize, int* returnSize, int** returnColumnSizes) {
    PointMapList *pointMapList = create_point_map_list();
    for (int i = 0; i < pointsSize; i++) {
        increment_count_map(pointMapList, points[i][0], points[i][1]);
    }

    int **result = (int**)malloc(eventSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(eventSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < eventSize; i++) {
        int x = event[i][0];
        int y = event[i][1];
        int count = 0;

        for (int j = 0; j < pointMapList->size; j++) {
            int px = pointMapList->map[j].x;
            int py = pointMapList->map[j].y;
            if (px == x || py == y) continue;

            int dx = abs(px - x);
            int dy = abs(py - y);
            if (dx != dy) continue;

            int x2 = px;
            int y2 = y;
            int x3 = x;
            int y3 = py;

            int c1 = get_count_map(pointMapList, x2, y2);
            int c2 = get_count_map(pointMapList, x3, y3);
            int c3 = get_count_map(pointMapList, x3, y2);

            count += c1 * c2 * c3;
        }

        if (count > 0) {
            result[*returnSize] = (int*)malloc(1 * sizeof(int));
            result[*returnSize][0] = count;
            (*returnColumnSizes)[*returnSize] = 1;
            (*returnSize)++;
        }
    }

    return result;
}