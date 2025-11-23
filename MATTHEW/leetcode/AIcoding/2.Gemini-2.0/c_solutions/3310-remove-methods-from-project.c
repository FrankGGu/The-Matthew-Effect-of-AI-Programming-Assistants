#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* name;
    int lines;
} Method;

int removeMethods(char* project, char** methodsToRemove, int methodsToRemoveSize) {
    int projectLines = 0;
    int currentMethodStart = -1;
    char* currentMethodName = NULL;
    int currentMethodLines = 0;
    int totalRemovedLines = 0;

    char* token = strtok(project, "\n");
    while (token != NULL) {
        projectLines++;

        if (strstr(token, "public") != NULL || strstr(token, "private") != NULL || strstr(token, "protected") != NULL) {
            if (strstr(token, "(") != NULL && strstr(token, ")") != NULL && strstr(token, "{") != NULL) {
                char* nameStart = strstr(token, " ");
                if (nameStart != NULL) {
                    nameStart++;
                    char* nameEnd = strstr(nameStart, "(");
                    if (nameEnd != NULL) {
                        int nameLength = nameEnd - nameStart;
                        currentMethodName = (char*)malloc(nameLength + 1);
                        strncpy(currentMethodName, nameStart, nameLength);
                        currentMethodName[nameLength] = '\0';
                        currentMethodStart = projectLines;
                        currentMethodLines = 1;

                        for (int i = 0; i < methodsToRemoveSize; i++) {
                            if (strcmp(currentMethodName, methodsToRemove[i]) == 0) {
                                totalRemovedLines++;
                                break;
                            }
                        }
                    } else {
                        currentMethodStart = -1;
                        if(currentMethodName) free(currentMethodName);
                        currentMethodName = NULL;
                    }
                } else {
                    currentMethodStart = -1;
                    if(currentMethodName) free(currentMethodName);
                    currentMethodName = NULL;
                }
            } else {
                currentMethodStart = -1;
                if(currentMethodName) free(currentMethodName);
                currentMethodName = NULL;
            }
        } else if (currentMethodStart != -1) {
            currentMethodLines++;

            int bracketCount = 0;
            char* temp = token;
            while(*temp != '\0'){
                if(*temp == '{') bracketCount++;
                else if(*temp == '}') bracketCount--;
                temp++;
            }

            if (bracketCount < 0 && strstr(token, "}") != NULL) {
                for (int i = 0; i < methodsToRemoveSize; i++) {
                    if (strcmp(currentMethodName, methodsToRemove[i]) == 0) {
                        totalRemovedLines += currentMethodLines;
                        break;
                    }
                }
                currentMethodStart = -1;
                if(currentMethodName) free(currentMethodName);
                currentMethodName = NULL;
            }
        }

        token = strtok(NULL, "\n");
    }
    if(currentMethodName) free(currentMethodName);

    return totalRemovedLines;
}