#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int adventureCamp(char ** expeditions, int expeditionsSize) {
    if (expeditionsSize <= 1) {
        return 0;
    }

    int *visited = (int *)malloc(1001 * sizeof(int));
    for (int i = 0; i <= 1000; i++) {
        visited[i] = 0;
    }

    int count1 = 0;
    char *token1 = expeditions[0];
    char *start1 = token1;
    while (*token1 != '\0') {
        if (*token1 == ',') {
            *token1 = '\0';
            int num = atoi(start1);
            if (num >= 1 && num <= 1000 && visited[num] == 0) {
                visited[num] = 1;
                count1++;
            }
            start1 = token1 + 1;
        }
        token1++;
    }
    int num = atoi(start1);
    if (num >= 1 && num <= 1000 && visited[num] == 0) {
        visited[num] = 1;
        count1++;
    }

    int max_diff = 0;
    for (int i = 1; i < expeditionsSize; i++) {
        int count2 = 0;
        int *temp_visited = (int *)malloc(1001 * sizeof(int));
        for (int j = 0; j <= 1000; j++) {
            temp_visited[j] = visited[j];
        }
        char *token2 = expeditions[i];
        char *start2 = token2;
        while (*token2 != '\0') {
            if (*token2 == ',') {
                *token2 = '\0';
                int num = atoi(start2);
                if (num >= 1 && num <= 1000 && temp_visited[num] == 0) {
                    temp_visited[num] = 1;
                    count2++;
                }
                start2 = token2 + 1;
            }
            token2++;
        }
        num = atoi(start2);
        if (num >= 1 && num <= 1000 && temp_visited[num] == 0) {
            temp_visited[num] = 1;
            count2++;
        }

        int diff = count2;
        for(int k = 1; k <= 1000; k++){
            if(visited[k] == 0 && temp_visited[k] == 1){
                visited[k] = 1;
            }
        }
        int new_count = 0;
        for(int k = 1; k <= 1000; k++){
            if(visited[k] == 1){
                new_count++;
            }
        }
        diff = new_count - count1;
        if (diff > max_diff) {
            max_diff = diff;
        }
        count1 = new_count;

        free(temp_visited);
    }
    free(visited);
    return max_diff;
}