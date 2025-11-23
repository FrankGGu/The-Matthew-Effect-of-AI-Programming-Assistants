#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define MAX_LEN 1000
#define ALPHABET_SIZE 26

typedef struct {
    char **words;
    int size;
} WordList;

typedef struct {
    char **list;
    int size;
    int capacity;
} PathList;

PathList* createPathList() {
    PathList *pathList = (PathList *)malloc(sizeof(PathList));
    pathList->size = 0;
    pathList->capacity = 10;
    pathList->list = (char **)malloc(pathList->capacity * sizeof(char *));
    return pathList;
}

void addPath(PathList *pathList, char *word) {
    if (pathList->size == pathList->capacity) {
        pathList->capacity *= 2;
        pathList->list = (char **)realloc(pathList->list, pathList->capacity * sizeof(char *));
    }
    pathList->list[pathList->size++] = strdup(word);
}

void freePathList(PathList *pathList) {
    for (int i = 0; i < pathList->size; i++) {
        free(pathList->list[i]);
    }
    free(pathList->list);
    free(pathList);
}

void dfs(char *currentWord, char *endWord, WordList *wordList, PathList *pathList, bool *visited, char **result, int *returnSize) {
    if (strcmp(currentWord, endWord) == 0) {
        result[(*returnSize)++] = strdup(currentWord);
        return;
    }

    for (int i = 0; i < wordList->size; i++) {
        if (!visited[i]) {
            visited[i] = true;
            dfs(wordList->words[i], endWord, wordList, pathList, visited, result, returnSize);
            visited[i] = false;
        }
    }
}

char **findLadders(char *beginWord, char *endWord, char **wordList, int wordListSize, int *returnSize) {
    WordList wl;
    wl.words = wordList;
    wl.size = wordListSize;

    char **result = (char **)malloc(MAX_LEN * sizeof(char *));
    *returnSize = 0;

    bool *visited = (bool *)calloc(wordListSize, sizeof(bool));
    PathList *pathList = createPathList();

    addPath(pathList, beginWord);
    dfs(beginWord, endWord, &wl, pathList, visited, result, returnSize);

    free(visited);
    freePathList(pathList);

    return result;
}