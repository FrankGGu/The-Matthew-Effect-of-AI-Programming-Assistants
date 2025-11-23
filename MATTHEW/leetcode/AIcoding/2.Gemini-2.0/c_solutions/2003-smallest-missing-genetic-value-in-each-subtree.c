#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* smallestMissingValueSubtree(int* parents, int parentsSize, int* nums, int numsSize, int** children, int* childrenSizes, int* returnSize){
    int* result = (int*)malloc(sizeof(int) * numsSize);
    *returnSize = numsSize;
    for (int i = 0; i < numsSize; i++) {
        result[i] = 1;
    }

    int node_one = -1;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            node_one = i;
            break;
        }
    }

    if (node_one == -1) {
        for (int i = 0; i < numsSize; i++) {
            result[i] = 1;
        }
        return result;
    }

    int missing = 1;
    char* visited = (char*)calloc(numsSize, sizeof(char));

    int current_node = node_one;

    while (current_node != -1) {
        visited[current_node] = 1;

        int queue[numsSize];
        int head = 0;
        int tail = 0;
        queue[tail++] = current_node;

        while (head < tail) {
            int u = queue[head++];

            for (int i = 0; i < childrenSizes[u]; i++) {
                int v = children[u][i];
                if (!visited[v]) {
                    visited[v] = 1;
                    queue[tail++] = v;
                }
            }
        }

        while (1) {
            int found = 0;
            for (int i = 0; i < numsSize; i++) {
                if (nums[i] == missing && visited[i]) {
                    missing++;
                    found = 1;
                    break;
                }
            }
            if (!found) break;
        }

        result[current_node] = missing;
        current_node = parents[current_node];
    }

    for(int i = 0; i < numsSize; i++){
        if(result[i] == 1 && parents[i] != -1){
            result[i] = missing;
        }
    }

    free(visited);

    return result;
}