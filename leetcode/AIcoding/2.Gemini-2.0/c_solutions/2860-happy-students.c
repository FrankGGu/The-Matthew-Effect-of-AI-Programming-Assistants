#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int maximumStudents(int* seats, int seatsSize){
    qsort(seats, seatsSize, sizeof(int), cmpfunc);
    int count = 0;
    for(int i = 0; i < seatsSize; i++){
        if(seats[i] <= count + 1){
            count++;
        } else {
            break;
        }
    }
    return count;
}