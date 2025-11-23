#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SIZE 1000

typedef struct {
    char ***matrix;
    int *count;
    int size;
} Graph;

Graph* createGraph(int size) {
    Graph *g = (Graph *)malloc(sizeof(Graph));
    g->size = size;
    g->count = (int *)calloc(size, sizeof(int));
    g->matrix = (char ***)malloc(size * sizeof(char **));
    for (int i = 0; i < size; i++) {
        g->matrix[i] = (char **)malloc(size * sizeof(char *));
        for (int j = 0; j < size; j++) {
            g->matrix[i][j] = NULL;
        }
    }
    return g;
}

void addEdge(Graph *g, int from, int to, char *toCity) {
    g->matrix[from][g->count[from]] = toCity;
    g->count[from]++;
}

int cmp(const void *a, const void *b) {
    return strcmp(*(const char **)a, *(const char **)b);
}

void dfs(Graph *g, int *visited, int *itinerary, int *itinerarySize, int *resultSize, char **result) {
    if (*itinerarySize == g->size) {
        result[*resultSize] = (char *)malloc(100 * sizeof(char));
        for (int i = 0; i < *itinerarySize; i++) {
            strcat(result[*resultSize], itinerary[i] == 0 ? "JFK" : g->matrix[itinerary[i]][0]);
            if (i < *itinerarySize - 1) strcat(result[*resultSize], "->");
        }
        (*resultSize)++;
        return;
    }

    for (int i = 0; i < g->size; i++) {
        if (visited[i] < g->count[i]) {
            visited[i]++;
            itinerary[*itinerarySize] = i;
            dfs(g, visited, itinerary, itinerarySize, resultSize, result);
            visited[i]--;
        }
    }
}

char **findItinerary(char **tickets, int ticketsSize, int *returnSize) {
    Graph *g = createGraph(ticketsSize);
    char **result = (char **)malloc(100 * sizeof(char *));
    int *itinerary = (int *)malloc(ticketsSize * sizeof(int));
    int *visited = (int *)calloc(ticketsSize, sizeof(int));
    *returnSize = 0;

    char **src = (char **)malloc(ticketsSize * sizeof(char *));
    char **dst = (char **)malloc(ticketsSize * sizeof(char *));

    for (int i = 0; i < ticketsSize; i++) {
        src[i] = tickets[i];
        dst[i] = tickets[i] + 4;
        addEdge(g, src[i][0] - 'A', dst[i][0] - 'A', dst[i]);
    }

    for (int i = 0; i < g->size; i++) {
        qsort(g->matrix[i], g->count[i], sizeof(char *), cmp);
    }

    itinerary[0] = 0;
    dfs(g, visited, itinerary, &itinerarySize, returnSize, result);

    free(g->count);
    for (int i = 0; i < g->size; i++) {
        free(g->matrix[i]);
    }
    free(g->matrix);
    free(g);
    free(itinerary);
    free(visited);
    free(src);
    free(dst);

    return result;
}