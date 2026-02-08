#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minMutation(char * startGene, char * endGene, char ** bank, int bankSize){
    int len = strlen(startGene);
    int end_found = 0;
    for (int i = 0; i < bankSize; i++) {
        if (strcmp(bank[i], endGene) == 0) {
            end_found = 1;
            break;
        }
    }
    if (!end_found) return -1;

    int *visited = (int *)calloc(bankSize, sizeof(int));
    int queue_size = bankSize + 2;
    char **queue = (char **)malloc(queue_size * sizeof(char *));
    int *level = (int *)malloc(queue_size * sizeof(int));
    int head = 0, tail = 0;

    queue[tail] = strdup(startGene);
    level[tail++] = 0;

    while (head < tail) {
        char *curr = queue[head];
        int curr_level = level[head++];

        if (strcmp(curr, endGene) == 0) {
            int result = curr_level;
            for (int i = 0; i < tail; i++) {
                free(queue[i]);
            }
            free(queue);
            free(level);
            free(visited);
            return result;
        }

        for (int i = 0; i < bankSize; i++) {
            if (!visited[i]) {
                int diff = 0;
                for (int j = 0; j < len; j++) {
                    if (curr[j] != bank[i][j]) {
                        diff++;
                    }
                }
                if (diff == 1) {
                    visited[i] = 1;
                    queue[tail] = strdup(bank[i]);
                    level[tail++] = curr_level + 1;
                }
            }
        }
        free(curr);
    }

    for (int i = 0; i < tail; i++) {
        free(queue[i]);
    }
    free(queue);
    free(level);
    free(visited);
    return -1;
}