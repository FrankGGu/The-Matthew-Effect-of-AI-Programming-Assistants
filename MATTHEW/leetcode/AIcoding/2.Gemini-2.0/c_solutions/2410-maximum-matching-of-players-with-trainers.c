#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int matchPlayersAndTrainers(int* players, int playersSize, int* trainers, int trainersSize){
    qsort(players, playersSize, sizeof(int), cmpfunc);
    qsort(trainers, trainersSize, sizeof(int), cmpfunc);

    int i = 0;
    int j = 0;
    int count = 0;

    while (i < playersSize && j < trainersSize) {
        if (players[i] <= trainers[j]) {
            count++;
            i++;
            j++;
        } else {
            j++;
        }
    }

    return count;
}