#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* circularGameLosers(int n, int k, int* returnSize){
    bool* visited = (bool*)malloc(n * sizeof(bool));
    for (int i = 0; i < n; i++) {
        visited[i] = false;
    }

    int current = 0;
    int step = k;
    visited[current] = true;

    while (true) {
        current = (current + step) % n;
        if (visited[current]) {
            break;
        }
        visited[current] = true;
        step += k;
    }

    int count = 0;
    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            count++;
        }
    }

    int* result = (int*)malloc(count * sizeof(int));
    int index = 0;
    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            result[index++] = i + 1;
        }
    }

    *returnSize = count;
    return result;
}