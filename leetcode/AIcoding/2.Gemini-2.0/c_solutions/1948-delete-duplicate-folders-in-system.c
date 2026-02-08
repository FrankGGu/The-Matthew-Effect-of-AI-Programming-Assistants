#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    char *name;
    struct TrieNode *children[27];
    int id;
} TrieNode;

TrieNode *createNode(char *name) {
    TrieNode *node = (TrieNode *)malloc(sizeof(TrieNode));
    node->name = strdup(name);
    for (int i = 0; i < 27; i++) {
        node->children[i] = NULL;
    }
    node->id = -1;
    return node;
}

void insert(TrieNode *root, char **path, int pathSize) {
    TrieNode *curr = root;
    for (int i = 0; i < pathSize; i++) {
        int index = path[i][0] == '#' ? 26 : path[i][0] - 'a';
        if (curr->children[index] == NULL) {
            curr->children[index] = createNode(path[i]);
        }
        curr = curr->children[index];
    }
}

char *serialize(TrieNode *node, char *buffer, int *index, int *idCounter, int *duplicateIds) {
    if (node == NULL) {
        return "";
    }

    buffer[(*index)++] = '(';

    for (int i = 0; i < 27; i++) {
        char temp[10000] = "";
        if (node->children[i] != NULL) {
            serialize(node->children[i], buffer, index, idCounter, duplicateIds);
        }
    }

    buffer[(*index)++] = ')';
    buffer[*index] = '\0';

    char *serialized = strdup(buffer);

    if (node->id == -1) {
        node->id = (*idCounter)++;
    }

    return serialized;
}

void dfs(TrieNode *node, char ***result, int *resultSize, char **path, int pathSize, int *duplicateIds) {
    if (node == NULL) {
        return;
    }

    bool isDuplicate = false;
    for (int i = 0; i < 1000; i++) {
        if (duplicateIds[i] == node->id && node->id != -1) {
            isDuplicate = true;
            break;
        }
    }

    if (!isDuplicate && pathSize > 0) {
        (*result) = (char **)realloc(*result, sizeof(char *) * (*resultSize + 1));
        (*result)[*resultSize] = (char *)malloc(sizeof(char) * 100);
        strcpy((*result)[*resultSize], path[pathSize - 1]);
        (*resultSize)++;
    }

    for (int i = 0; i < 27; i++) {
        if (node->children[i] != NULL && !isDuplicate) {
            path[pathSize] = node->children[i]->name;
            dfs(node->children[i], result, resultSize, path, pathSize + 1, duplicateIds);
        }
    }
}

char ***deleteDuplicateFolder(char ***paths, int pathsSize, int *pathsColSize, int *returnSize, int **returnColumnSizes) {
    TrieNode *root = createNode("#root");

    for (int i = 0; i < pathsSize; i++) {
        insert(root, paths[i], pathsColSize[i]);
    }

    char buffer[100000];
    int index = 0;
    int idCounter = 0;
    int duplicateIds[1000] = {0};
    char *serialized[1000] = {NULL};
    int serializedCount = 0;

    serialize(root, buffer, &index, &idCounter, duplicateIds);

    char **folders = (char **)malloc(sizeof(char *) * 1000);
    int *folderCount = (int *)calloc(1000, sizeof(int));

    TrieNode *nodeQueue[10000];
    int head = 0;
    int tail = 0;
    nodeQueue[tail++] = root;

    while(head < tail){
        TrieNode *node = nodeQueue[head++];

        char buffer2[100000];
        int index2 = 0;
        serialize(node, buffer2, &index2, &idCounter, duplicateIds);

        bool found = false;
        for(int i = 0; i < serializedCount; i++){
            if(strcmp(serialized[i], buffer2) == 0){
                found = true;
                duplicateIds[node->id] = node->id;
                break;
            }
        }

        if(!found){
            serialized[serializedCount++] = strdup(buffer2);
        }

        for(int i = 0; i < 27; i++){
            if(node->children[i] != NULL){
                nodeQueue[tail++] = node->children[i];
            }
        }
    }

    char ***result = (char ***)malloc(sizeof(char **) * pathsSize);
    *returnSize = 0;
    *returnColumnSizes = (int *)malloc(sizeof(int) * pathsSize);

    char *path[1000];
    int pathSize = 0;
    dfs(root, result, returnSize, path, pathSize, duplicateIds);

    qsort(*result, *returnSize, sizeof(char *), (int (*)(const void *, const void *))strcmp);

    int *colSizes = (int *)malloc(sizeof(int) * (*returnSize));
    for (int i = 0; i < *returnSize; i++) {
        colSizes[i] = 1;
    }
    *returnColumnSizes = colSizes;

    return result;
}