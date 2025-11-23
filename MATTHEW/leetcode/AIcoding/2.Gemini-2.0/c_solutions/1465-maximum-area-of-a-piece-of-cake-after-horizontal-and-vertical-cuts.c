#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int maxArea(int h, int w, int* horizontalCuts, int horizontalCutsSize, int* verticalCuts, int verticalCutsSize){
    long long maxHeight = 0, maxWidth = 0;
    long long mod = 1000000007;

    qsort(horizontalCuts, horizontalCutsSize, sizeof(int), cmpfunc);
    qsort(verticalCuts, verticalCutsSize, sizeof(int), cmpfunc);

    maxHeight = horizontalCuts[0];
    for(int i = 1; i < horizontalCutsSize; i++){
        if(horizontalCuts[i] - horizontalCuts[i-1] > maxHeight){
            maxHeight = horizontalCuts[i] - horizontalCuts[i-1];
        }
    }
    if(h - horizontalCuts[horizontalCutsSize-1] > maxHeight){
        maxHeight = h - horizontalCuts[horizontalCutsSize-1];
    }

    maxWidth = verticalCuts[0];
    for(int i = 1; i < verticalCutsSize; i++){
        if(verticalCuts[i] - verticalCuts[i-1] > maxWidth){
            maxWidth = verticalCuts[i] - verticalCuts[i-1];
        }
    }
    if(w - verticalCuts[verticalCutsSize-1] > maxWidth){
        maxWidth = w - verticalCuts[verticalCutsSize-1];
    }

    return (maxHeight * maxWidth) % mod;
}