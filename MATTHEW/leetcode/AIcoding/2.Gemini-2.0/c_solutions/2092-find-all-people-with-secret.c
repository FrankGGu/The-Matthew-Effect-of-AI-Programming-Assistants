#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
    int time;
} Meeting;

int compareMeetings(const void *a, const void *b) {
    return ((Meeting *)a)->time - ((Meeting *)b)->time;
}

int* findAllPeople(int n, int** meetings, int meetingsSize, int* meetingsColSize, int firstPerson, int* returnSize) {
    int *parent = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
    }

    parent[firstPerson] = 0;

    Meeting *meetingArray = (Meeting *)malloc(meetingsSize * sizeof(Meeting));
    for (int i = 0; i < meetingsSize; i++) {
        meetingArray[i].x = meetings[i][0];
        meetingArray[i].y = meetings[i][1];
        meetingArray[i].time = meetings[i][2];
    }

    qsort(meetingArray, meetingsSize, sizeof(Meeting), compareMeetings);

    int *result = (int *)malloc(n * sizeof(int));
    int resultIndex = 0;

    int *know = (int *)malloc(n * sizeof(int));
    for(int i=0; i<n; i++) know[i] = 0;
    know[0] = 1;
    know[firstPerson] = 1;

    int i = 0;
    while (i < meetingsSize) {
        int j = i;
        int max_j = i;

        while (j < meetingsSize && meetingArray[j].time == meetingArray[i].time) {
            j++;
        }

        int *people = (int *)malloc((j - i) * 2 * sizeof(int));
        int peopleSize = 0;

        for (int k = i; k < j; k++) {
            int x = meetingArray[k].x;
            int y = meetingArray[k].y;

            people[peopleSize++] = x;
            people[peopleSize++] = y;
        }

        for(int k=0; k<peopleSize; k++){
          int x = people[k];
          if(know[x] == 1){
            for(int l=i; l<j; l++){
              know[meetingArray[l].x] = 1;
              know[meetingArray[l].y] = 1;
            }
            break;
          }
        }
        free(people);

        i = j;
    }

    for (int i = 0; i < n; i++) {
        if (know[i] == 1) {
            result[resultIndex++] = i;
        }
    }

    *returnSize = resultIndex;
    free(parent);
    free(meetingArray);
    free(know);
    return result;
}