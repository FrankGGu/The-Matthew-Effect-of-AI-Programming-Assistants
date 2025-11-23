#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int arrive;
    int leave;
    int index;
} Person;

int compare(const void *a, const void *b) {
    return ((Person *)a)->arrive - ((Person *)b)->arrive;
}

int compareLeave(const void *a, const void *b) {
    return ((Person *)a)->leave - ((Person *)b)->leave;
}

int kthSmallestChair(int** times, int timesSize, int* timesColSize, int k) {
    Person *people = (Person *)malloc(timesSize * sizeof(Person));
    for (int i = 0; i < timesSize; i++) {
        people[i].arrive = times[i][0];
        people[i].leave = times[i][1];
        people[i].index = i;
    }

    qsort(people, timesSize, sizeof(Person), compare);

    int *chairs = (int *)malloc(timesSize * sizeof(int));
    for (int i = 0; i < timesSize; i++) chairs[i] = i;

    int *occupied = (int *)malloc(timesSize * sizeof(int));
    int occupiedSize = 0;

    for (int i = 0; i < timesSize; i++) {
        int personIndex = people[i].index;
        int arriveTime = people[i].arrive;
        int leaveTime = people[i].leave;

        while (occupiedSize > 0 && occupied[0] <= arriveTime) {
            int chair = occupied[0];
            memmove(occupied, occupied + 1, (occupiedSize - 1) * sizeof(int));
            occupiedSize--;
            chairs[occupiedSize] = chair;
        }

        int chair = chairs[0];
        memmove(chairs, chairs + 1, (timesSize - 1) * sizeof(int));
        chairs[timesSize - 1] = -1;

        if (occupiedSize == 0) {
            occupied[0] = leaveTime;
            occupiedSize++;
        } else {
            int j = occupiedSize - 1;
            while (j >= 0 && occupied[j] > leaveTime) {
                occupied[j + 1] = occupied[j];
                j--;
            }
            occupied[j + 1] = leaveTime;
            occupiedSize++;
        }

        if (personIndex == k - 1) {
            free(people);
            free(chairs);
            free(occupied);
            return chair;
        }
    }

    free(people);
    free(chairs);
    free(occupied);
    return -1;
}