#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_PATH_LEN 200

int duplicateFile(char ***paths, int pathsSize, int *pathsColSize, char ***result, int *resultSize) {
    *result = NULL;
    *resultSize = 0;

    if (pathsSize == 0) {
        return 0;
    }

    char ***groups = (char***)malloc(pathsSize * sizeof(char**));
    int *groupSizes = (int*)malloc(pathsSize * sizeof(int));
    int groupCount = 0;

    for (int i = 0; i < pathsSize; i++) {
        for (int j = 1; j < pathsColSize[i]; j++) {
            char *contentStart = strchr(paths[i][j], '(');
            if (contentStart == NULL) continue;

            char *contentEnd = strchr(paths[i][j], ')');
            if (contentEnd == NULL) continue;

            int contentLength = contentEnd - contentStart - 1;
            char *content = (char*)malloc((contentLength + 1) * sizeof(char));
            strncpy(content, contentStart + 1, contentLength);
            content[contentLength] = '\0';

            char *filename = (char*)malloc((contentStart - paths[i][j] + 1) * sizeof(char));
            strncpy(filename, paths[i][j], contentStart - paths[i][j]);
            filename[contentStart - paths[i][j]] = '\0';

            char *fullPath = (char*)malloc((strlen(paths[i][0]) + strlen(filename) + 2) * sizeof(char));
            strcpy(fullPath, paths[i][0]);
            strcat(fullPath, "/");
            strcat(fullPath, filename);

            int found = 0;
            for (int k = 0; k < groupCount; k++) {
                if (strcmp(content, groups[k][0]) == 0) {
                    groupSizes[k]++;
                    groups[k] = (char**)realloc(groups[k], (groupSizes[k] + 1) * sizeof(char*));
                    groups[k][groupSizes[k]] = fullPath;
                    found = 1;
                    break;
                }
            }

            if (!found) {
                groups[groupCount] = (char**)malloc(2 * sizeof(char*));
                groups[groupCount][0] = content;
                groups[groupCount][1] = fullPath;
                groupSizes[groupCount] = 1;
                groupCount++;
            } else {
                free(content);
            }
            free(filename);
        }
    }

    int count = 0;
    for (int i = 0; i < groupCount; i++) {
        if (groupSizes[i] > 1) {
            count++;
        }
    }

    if (count == 0) {
        free(groups);
        free(groupSizes);
        return 0;
    }

    *result = (char***)malloc(count * sizeof(char**));
    *resultSize = count;

    int resultIndex = 0;
    for (int i = 0; i < groupCount; i++) {
        if (groupSizes[i] > 1) {
            (*result)[resultIndex] = (char**)malloc(groupSizes[i] * sizeof(char*));
            for (int j = 0; j < groupSizes[i]; j++) {
                (*result)[resultIndex][j] = groups[i][j+1];
            }

            resultIndex++;
        } else {
          free(groups[i][0]);
          free(groups[i][1]);
          free(groups[i]);
        }
    }

    free(groups);
    free(groupSizes);

    int *colSizes = (int*)malloc(count * sizeof(int));
    for (int i = 0; i < count; i++) {
        colSizes[i] = groupSizes[i];
        for(int j = 0; j < groupCount; j++){
            if(groupSizes[j] > 1){
                groupSizes[j] = 0;
                break;
            }
        }
    }

    return count;
}