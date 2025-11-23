#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Person;

int compare(const void* a, const void* b) {
    Person* p1 = (Person*)a;
    Person* p2 = (Person*)b;
    if (p1->x != p2->x) {
        return p1->x - p2->x;
    } else {
        return p2->y - p1->y;
    }
}

long long numberOfWays(int** points, int pointsSize, int* pointsColSize) {
    Person people[pointsSize];
    for (int i = 0; i < pointsSize; i++) {
        people[i].x = points[i][0];
        people[i].y = points[i][1];
    }

    qsort(people, pointsSize, sizeof(Person), compare);

    long long count = 0;
    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            if (people[j].y >= people[i].y) continue;

            int blocked = 0;
            for (int k = 0; k < pointsSize; k++) {
                if (k == i || k == j) continue;
                if (people[k].x >= people[i].x && people[k].x <= people[j].x &&
                    people[k].y >= people[j].y && people[k].y <= people[i].y) {
                    blocked = 1;
                    break;
                }
            }
            if (!blocked) count++;
        }
    }

    return count;
}