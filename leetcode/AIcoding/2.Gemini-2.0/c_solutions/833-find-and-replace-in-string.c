#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * findReplaceString(char * s, int* indices, int indicesSize, char ** sources, int sourcesSize, char ** targets, int targetsSize){
    int sLen = strlen(s);
    char* res = (char*)malloc(sizeof(char) * (sLen * 3 + 1));
    res[0] = '\0';
    int i = 0;
    int resIndex = 0;

    int* sortedIndices = (int*)malloc(sizeof(int) * indicesSize);
    for (int k = 0; k < indicesSize; k++) {
        sortedIndices[k] = indices[k];
    }

    for (int k = 0; k < indicesSize - 1; k++) {
        for (int j = 0; j < indicesSize - k - 1; j++) {
            if (sortedIndices[j] > sortedIndices[j + 1]) {
                int temp = sortedIndices[j];
                sortedIndices[j] = sortedIndices[j + 1];
                sortedIndices[j + 1] = temp;
            }
        }
    }

    while (i < sLen) {
        int found = 0;
        for (int j = 0; j < indicesSize; j++) {
            if (indices[j] == sortedIndices[0]) {
                int indexInOriginal = j;
                int startIndex = indices[indexInOriginal];
                int sourceLen = strlen(sources[indexInOriginal]);

                if (strncmp(s + startIndex, sources[indexInOriginal], sourceLen) == 0) {
                    strcat(res, targets[indexInOriginal]);
                    resIndex += strlen(targets[indexInOriginal]);
                    i += sourceLen;
                    found = 1;
                    int tempIndex = 0;
                    int* tempIndices = (int*)malloc(sizeof(int) * (indicesSize -1));
                    for(int k = 0; k < indicesSize; k++){
                        if(indices[k] != sortedIndices[0]){
                            tempIndices[tempIndex++] = indices[k];
                        }
                    }
                    free(indices);
                    indices = tempIndices;
                    indicesSize--;

                    int tempSortedIndex = 0;
                    int* tempSortedIndices = (int*)malloc(sizeof(int) * (indicesSize));
                    for(int k = 0; k < indicesSize + 1; k++){
                        if(sortedIndices[k] != sortedIndices[0]){
                            tempSortedIndices[tempSortedIndex++] = sortedIndices[k];
                        }
                    }
                    free(sortedIndices);
                    sortedIndices = tempSortedIndices;

                    break;
                }
            }
        }
        if (!found) {
            res[resIndex++] = s[i++];
            res[resIndex] = '\0';
        }
    }
    free(sortedIndices);
    return res;
}