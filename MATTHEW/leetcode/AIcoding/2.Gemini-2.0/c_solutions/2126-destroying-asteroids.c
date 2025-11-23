#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

bool asteroidsDestroyed(int mass, int* asteroids, int asteroidsSize){
    qsort(asteroids, asteroidsSize, sizeof(int), cmpfunc);

    long long currentMass = (long long)mass;

    for(int i = 0; i < asteroidsSize; i++){
        if(currentMass < asteroids[i]){
            return false;
        }
        currentMass += asteroids[i];
    }

    return true;
}