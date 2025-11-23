#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minJumps(int* arr, int arrSize) {
    if (arrSize <= 1) return 0;

    int *queue = (int*)malloc(sizeof(int) * arrSize);
    int *visited = (int*)calloc(arrSize, sizeof(int));
    int head = 0, tail = 0;
    queue[tail++] = 0;
    visited[0] = 1;

    int jumps = 0;

    typedef struct {
        int val;
        int *indices;
        int count;
    } Group;

    Group *groups = NULL;
    int groupsCount = 0;

    int *indices = (int*)malloc(sizeof(int) * arrSize);
    int indicesCount = 0;

    for(int i = 0; i < arrSize; i++){
        int found = 0;
        for(int j = 0; j < groupsCount; j++){
            if(groups[j].val == arr[i]){
                groups[j].indices[groups[j].count++] = i;
                found = 1;
                break;
            }
        }

        if(!found){
            groups = (Group*)realloc(groups, sizeof(Group) * (groupsCount + 1));
            groups[groupsCount].val = arr[i];
            groups[groupsCount].indices = (int*)malloc(sizeof(int) * arrSize);
            groups[groupsCount].indices[0] = i;
            groups[groupsCount].count = 1;
            groupsCount++;
        }
    }

    while (head < tail) {
        int size = tail - head;
        for (int i = 0; i < size; i++) {
            int curr = queue[head++];
            if (curr == arrSize - 1) {
                free(queue);
                free(visited);
                for(int j = 0; j < groupsCount; j++){
                    free(groups[j].indices);
                }
                free(groups);
                return jumps;
            }

            if (curr + 1 < arrSize && !visited[curr + 1]) {
                queue[tail++] = curr + 1;
                visited[curr + 1] = 1;
            }
            if (curr - 1 >= 0 && !visited[curr - 1]) {
                queue[tail++] = curr - 1;
                visited[curr - 1] = 1;
            }

            for(int j = 0; j < groupsCount; j++){
                int found = 0;
                for(int k = 0; k < groups[j].count; k++){
                    if(groups[j].indices[k] == curr){
                        found = 1;
                        break;
                    }
                }
                if(found){
                    for(int k = 0; k < groups[j].count; k++){
                        if(!visited[groups[j].indices[k]]){
                            queue[tail++] = groups[j].indices[k];
                            visited[groups[j].indices[k]] = 1;
                        }
                    }
                    groups[j].count = 0;
                    free(groups[j].indices);
                    groups[j].indices = NULL;
                    break;
                }
            }
        }
        jumps++;
    }

    free(queue);
    free(visited);
    for(int j = 0; j < groupsCount; j++){
        free(groups[j].indices);
    }
    free(groups);
    return -1;
}