#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Folder {
    char* name;
    struct Folder** children;
    int childCount;
    int isUnique;
} Folder;

Folder* createFolder(char* name) {
    Folder* folder = (Folder*)malloc(sizeof(Folder));
    folder->name = name;
    folder->children = NULL;
    folder->childCount = 0;
    folder->isUnique = 1;
    return folder;
}

void addFolder(Folder* parent, Folder* child) {
    parent->childCount++;
    parent->children = (Folder**)realloc(parent->children, sizeof(Folder*) * parent->childCount);
    parent->children[parent->childCount - 1] = child;
}

void freeFolder(Folder* folder) {
    if (!folder) return;
    for (int i = 0; i < folder->childCount; i++) {
        freeFolder(folder->children[i]);
    }
    free(folder->children);
    free(folder->name);
    free(folder);
}

char* getHashKey(Folder* node) {
    char* key = (char*)malloc(1);
    key[0] = '\0';
    for (int i = 0; i < node->childCount; i++) {
        Folder* child = node->children[i];
        char* childKey = getHashKey(child);
        int len = strlen(key) + strlen(childKey) + 2;
        char* newKey = (char*)malloc(len);
        snprintf(newKey, len, "%s,%s", key, childKey);
        free(key);
        key = newKey;
    }
    return key;
}

void markDuplicates(Folder* node, int* count, char** hashSet) {
    char* key = getHashKey(node);
    int found = 0;
    for (int i = 0; i < *count; i++) {
        if (strcmp(hashSet[i], key) == 0) {
            found = 1;
            break;
        }
    }
    if (found) {
        node->isUnique = 0;
    } else {
        hashSet[*count] = key;
        (*count)++;
    }
    for (int i = 0; i < node->childCount; i++) {
        markDuplicates(node->children[i], count, hashSet);
    }
}

Folder* deleteDuplicateFolders(Folder* root) {
    int count = 0;
    char** hashSet = (char**)malloc(1000 * sizeof(char*));
    markDuplicates(root, &count, hashSet);
    for (int i = 0; i < root->childCount; i++) {
        if (!root->children[i]->isUnique) {
            freeFolder(root->children[i]);
            root->children[i] = NULL;
        }
    }
    return root;
}