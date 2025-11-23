#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** findAllRecipes(char ** recipes, int recipesSize, char *** ingredients, int * ingredientsSize, int ingredientsColSize[], char ** supplies, int suppliesSize, int* returnSize){
    int *indegree = (int*)malloc(sizeof(int) * recipesSize);
    memset(indegree, 0, sizeof(int) * recipesSize);

    int **graph = (int**)malloc(sizeof(int*) * recipesSize);
    for (int i = 0; i < recipesSize; i++) {
        graph[i] = (int*)malloc(sizeof(int) * recipesSize);
        memset(graph[i], 0, sizeof(int) * recipesSize);
    }

    for (int i = 0; i < recipesSize; i++) {
        for (int j = 0; j < ingredientsSize[i]; j++) {
            bool found = false;
            for (int k = 0; k < recipesSize; k++) {
                if (strcmp(ingredients[i][j], recipes[k]) == 0) {
                    graph[k][i] = 1;
                    indegree[i]++;
                    found = true;
                    break;
                }
            }
            if (!found) {
                bool supplyFound = false;
                for (int k = 0; k < suppliesSize; k++) {
                    if (strcmp(ingredients[i][j], supplies[k]) == 0) {
                        supplyFound = true;
                        break;
                    }
                }
                if (!supplyFound) {
                    indegree[i] = -1; 
                    break;
                }
            }
        }
    }

    int *queue = (int*)malloc(sizeof(int) * recipesSize);
    int head = 0, tail = 0;
    for (int i = 0; i < recipesSize; i++) {
        if (indegree[i] == 0) {
            queue[tail++] = i;
        }
    }

    char **result = (char**)malloc(sizeof(char*) * recipesSize);
    *returnSize = 0;

    while (head < tail) {
        int u = queue[head++];
        result[(*returnSize)++] = recipes[u];

        for (int v = 0; v < recipesSize; v++) {
            if (graph[u][v] == 1) {
                indegree[v]--;
                if (indegree[v] == 0) {
                    queue[tail++] = v;
                }
            }
        }
    }

    for (int i = 0; i < recipesSize; i++) {
        free(graph[i]);
    }
    free(graph);
    free(indegree);
    free(queue);

    result = (char**)realloc(result, sizeof(char*) * (*returnSize));

    return result;
}