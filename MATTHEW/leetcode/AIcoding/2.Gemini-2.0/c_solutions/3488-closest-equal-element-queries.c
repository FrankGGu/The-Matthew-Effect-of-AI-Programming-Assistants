#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* closestEqualElements(int* arr, int arrSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int index1 = queries[i][0];
        int index2 = queries[i][1];
        int minDist = -1;

        for (int j = 0; j < arrSize; j++) {
            if (arr[j] == arr[index1]) {
                int dist = abs(j - index1);
                if (dist != 0) {
                    if (minDist == -1 || dist < minDist) {
                        minDist = dist;
                    }
                }
            }
        }

        for (int j = 0; j < arrSize; j++) {
            if (arr[j] == arr[index2]) {
                int dist = abs(j - index2);
                if (dist != 0) {
                    if (minDist == -1 || dist < minDist) {
                        minDist = dist;
                    }
                }
            }
        }

        if(arr[index1] != arr[index2]){
            minDist = -1;
        } else {
           if(index1 == index2){
               minDist = 0;
           } else {
                minDist = abs(index1 - index2);
           }
        }

        result[i] = minDist;
    }

    return result;
}