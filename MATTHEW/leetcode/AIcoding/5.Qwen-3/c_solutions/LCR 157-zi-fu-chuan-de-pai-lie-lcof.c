#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** goodsOrder(char** goods, int goodsSize, int* returnSize) {
    char** result = (char**)malloc(goodsSize * sizeof(char*));
    *returnSize = 0;

    int* visited = (int*)calloc(goodsSize, sizeof(int));

    void backtrack(char** goods, int goodsSize, char* path, int pathLen, int* visited, char*** result, int* returnSize) {
        if (pathLen == goodsSize) {
            (*result)[*returnSize] = (char*)malloc((pathLen + 1) * sizeof(char));
            strcpy((*result)[*returnSize], path);
            (*returnSize)++;
            return;
        }

        for (int i = 0; i < goodsSize; i++) {
            if (visited[i]) continue;

            if (i > 0 && strcmp(goods[i], goods[i-1]) == 0 && visited[i-1] == 0) continue;

            visited[i] = 1;
            strcat(path, goods[i]);
            backtrack(goods, goodsSize, path, pathLen + strlen(goods[i]), visited, result, returnSize);
            visited[i] = 0;
            path[pathLen] = '\0';
        }
    }

    qsort(goods, goodsSize, sizeof(char*), (int (*)(const void*, const void*))strcmp);

    char* path = (char*)malloc((goodsSize * 10 + 1) * sizeof(char));
    path[0] = '\0';

    backtrack(goods, goodsSize, path, 0, visited, &result, returnSize);

    free(path);
    free(visited);

    return result;
}