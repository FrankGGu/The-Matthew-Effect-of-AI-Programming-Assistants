#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* processQueries(int* queries, int queriesSize, int m, int* returnSize){
    int *P = (int*)malloc(sizeof(int) * m);
    for(int i = 0; i < m; i++){
        P[i] = i + 1;
    }

    int *result = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;

    for(int i = 0; i < queriesSize; i++){
        int query = queries[i];
        int index = -1;
        for(int j = 0; j < m; j++){
            if(P[j] == query){
                index = j;
                break;
            }
        }

        result[i] = index;

        for(int j = index; j > 0; j--){
            P[j] = P[j - 1];
        }

        P[0] = query;
    }

    return result;
}