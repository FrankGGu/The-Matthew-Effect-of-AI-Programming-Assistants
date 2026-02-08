#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return strcmp(*(const char **)a, *(const char **)b);
}

char ** findItinerary(char *** tickets, int ticketsSize, int* ticketsColSize, int* returnSize) {
    int num_destinations = 0;
    for (int i = 0; i < ticketsSize; i++) {
        num_destinations++;
    }

    char **result = (char **)malloc(sizeof(char *) * (num_destinations + 1));
    *returnSize = 0;
    int *visited = (int *)calloc(ticketsSize, sizeof(int));

    char **path = (char **)malloc(sizeof(char*) * (num_destinations + 1));

    int path_index = 0;
    path[path_index++] = "JFK";

    void dfs(char *current_airport) {
        if (path_index == num_destinations + 1) {
            for (int i = 0; i < num_destinations + 1; i++) {
                result[i] = (char *)malloc(sizeof(char) * (strlen(path[i]) + 1));
                strcpy(result[i], path[i]);
            }
            *returnSize = num_destinations + 1;
            return;
        }

        char ***sorted_tickets = (char ***)malloc(sizeof(char**) * ticketsSize);
        for(int i = 0; i < ticketsSize; i++){
            sorted_tickets[i] = tickets[i];
        }

        qsort(sorted_tickets, ticketsSize, sizeof(char**), compare);

        for (int i = 0; i < ticketsSize; i++) {
            if (strcmp(sorted_tickets[i][0], current_airport) == 0 && !visited[i]) {
                visited[i] = 1;
                path[path_index++] = sorted_tickets[i][1];
                dfs(sorted_tickets[i][1]);
                if (*returnSize > 0) {
                    free(sorted_tickets);
                    return;
                }
                path_index--;
                visited[i] = 0;
            }
        }
        free(sorted_tickets);
    }

    dfs("JFK");

    free(path);
    free(visited);
    return result;
}