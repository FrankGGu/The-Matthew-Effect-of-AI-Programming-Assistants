#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int width;
    int height;
    int x;
    int y;
    char dir;
} Robot;

Robot* robotCreate(int width, int height) {
    Robot* obj = (Robot*)malloc(sizeof(Robot));
    obj->width = width;
    obj->height = height;
    obj->x = 0;
    obj->y = 0;
    obj->dir = 'E';
    return obj;
}

void robotMove(Robot* obj, int num) {
    int w = obj->width;
    int h = obj->height;
    num %= (2 * (w + h) - 4);

    while (num > 0) {
        if (obj->dir == 'E') {
            if (obj->x + num < w) {
                obj->x += num;
                num = 0;
            } else {
                num -= (w - 1 - obj->x);
                obj->x = w - 1;
                obj->dir = 'N';
            }
        } else if (obj->dir == 'N') {
            if (obj->y + num < h) {
                obj->y += num;
                num = 0;
            } else {
                num -= (h - 1 - obj->y);
                obj->y = h - 1;
                obj->dir = 'W';
            }
        } else if (obj->dir == 'W') {
            if (obj->x - num >= 0) {
                obj->x -= num;
                num = 0;
            } else {
                num -= (obj->x);
                obj->x = 0;
                obj->dir = 'S';
            }
        } else { // obj->dir == 'S'
            if (obj->y - num >= 0) {
                obj->y -= num;
                num = 0;
            } else {
                num -= (obj->y);
                obj->y = 0;
                obj->dir = 'E';
            }
        }
    }
}

int* robotGetPos(Robot* obj) {
    int* pos = (int*)malloc(sizeof(int) * 2);
    pos[0] = obj->x;
    pos[1] = obj->y;
    return pos;
}

char robotGetDir(Robot* obj) {
    return obj->dir;
}

void robotFree(Robot* obj) {
    free(obj);
}