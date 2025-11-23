#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_PATH_LEN 1000
#define MAX_CONTENT_LEN 200

typedef struct FileInfo {
    char filePath[MAX_PATH_LEN];
    char fileName[MAX_PATH_LEN];
    char content[MAX_CONTENT_LEN];
    struct FileInfo* next;
} FileInfo;

FileInfo* createFileInfo(const char* filePath, const char* fileName, const char* content) {
    FileInfo* fileInfo = (FileInfo*)malloc(sizeof(FileInfo));
    if (fileInfo) {
        strcpy(fileInfo->filePath, filePath);
        strcpy(fileInfo->fileName, fileName);
        strcpy(fileInfo->content, content);
        fileInfo->next = NULL;
    }
    return fileInfo;
}

char*** findDuplicate(char** paths, int pathsSize, int* returnSize, int** returnColumnSizes) {
    FileInfo* hashTable[101] = {NULL};
    *returnSize = 0;
    char*** result = (char***)malloc(pathsSize * sizeof(char**));
    *returnColumnSizes = (int*)malloc(pathsSize * sizeof(int));

    for (int i = 0; i < pathsSize; i++) {
        char* path = paths[i];
        char dirPath[MAX_PATH_LEN] = "";
        char* token = strtok(path, " ");
        if (token) {
            strcpy(dirPath, token);
        }

        token = strtok(NULL, " ");
        while (token) {
            char fileName[MAX_PATH_LEN] = "";
            char content[MAX_CONTENT_LEN] = "";
            char* openParen = strchr(token, '(');
            if (openParen) {
                strncpy(fileName, token, openParen - token);
                fileName[openParen - token] = '\0';
                strcpy(content, openParen + 1);
                content[strlen(content) - 1] = '\0';

                char filePath[MAX_PATH_LEN];
                sprintf(filePath, "%s/%s", dirPath, fileName);

                int hash = 0;
                for (int j = 0; content[j] != '\0'; j++) {
                    hash = (hash * 31 + content[j]) % 101;
                }

                FileInfo* newFileInfo = createFileInfo(filePath, fileName, content);
                if (!hashTable[hash]) {
                    hashTable[hash] = newFileInfo;
                } else {
                    FileInfo* current = hashTable[hash];
                    while (current->next) {
                        current = current->next;
                    }
                    current->next = newFileInfo;
                }
            }
            token = strtok(NULL, " ");
        }
    }

    for (int i = 0; i < 101; i++) {
        if (hashTable[i]) {
            FileInfo* current = hashTable[i];
            int count = 0;
            char content[MAX_CONTENT_LEN];
            strcpy(content, current->content);
            FileInfo* temp = current;
            while(temp){
                if(strcmp(content, temp->content) == 0){
                    count++;
                }
                temp = temp->next;
            }

            if (count > 1) {
                result[*returnSize] = (char**)malloc(count * sizeof(char*));
                (*returnColumnSizes)[*returnSize] = 0;

                FileInfo* temp2 = current;
                while(temp2){
                    if(strcmp(content, temp2->content) == 0){
                        result[*returnSize][(*returnColumnSizes)[*returnSize]] = (char*)malloc((strlen(temp2->filePath) + 1) * sizeof(char));
                        strcpy(result[*returnSize][(*returnColumnSizes)[*returnSize]], temp2->filePath);
                        (*returnColumnSizes)[*returnSize]++;
                    }
                    temp2 = temp2->next;
                }

                *returnSize = *returnSize + 1;
            }

            FileInfo* current2 = hashTable[i];
            FileInfo* next;
            while(current2){
                next = current2->next;
                free(current2);
                current2 = next;
            }
            hashTable[i] = NULL;
        }
    }

    return result;
}