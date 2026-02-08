#include <stdio.h>
#include <stdlib.h>

int* findSolution(int* queries, int queriesSize, int* resultSize) {
    int* answer = (int*)malloc(queriesSize * sizeof(int));
    int* position = (int*)malloc(26 * sizeof(int));
    for (int i = 0; i < 26; i++) {
        position[i] = i + 1;
    }
    for (int i = 0; i < queriesSize; i++) {
        int key = queries[i];
        int pos = position[key - 1];
        answer[i] = pos;
        for (int j = 0; j < 26; j++) {
            if (position[j] < pos) {
                position[j]++;
            }
        }
        position[key - 1] = 1;
    }
    *resultSize = queriesSize;
    return answer;
}