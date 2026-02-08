#include <stdlib.h>
#include <string.h>

typedef struct {
    char* str;
    int count;
} StringFreq;

char* kthDistinct(char** arr, int arrSize, int k) {
    StringFreq* freqMap = (StringFreq*)malloc(arrSize * sizeof(StringFreq));
    if (freqMap == NULL) {
        return "";
    }
    int uniqueCount = 0;

    for (int i = 0; i < arrSize; i++) {
        char* currentStr = arr[i];
        int found = 0;
        for (int j = 0; j < uniqueCount; j++) {
            if (strcmp(freqMap[j].str, currentStr) == 0) {
                freqMap[j].count++;
                found = 1;
                break;
            }
        }
        if (!found) {
            freqMap[uniqueCount].str = (char*)malloc((strlen(currentStr) + 1) * sizeof(char));
            if (freqMap[uniqueCount].str == NULL) {
                for (int j = 0; j < uniqueCount; j++) {
                    free(freqMap[j].str);
                }
                free(freqMap);
                return "";
            }
            strcpy(freqMap[uniqueCount].str, currentStr);
            freqMap[uniqueCount].count = 1;
            uniqueCount++;
        }
    }

    char* result = "";
    for (int i = 0; i < arrSize; i++) {
        char* currentStr = arr[i];
        for (int j = 0; j < uniqueCount; j++) {
            if (strcmp(freqMap[j].str, currentStr) == 0) {
                if (freqMap[j].count == 1) {
                    k--;
                    if (k == 0) {
                        result = currentStr;
                        break;
                    }
                }
                break;
            }
        }
        if (k == 0) {
            break;
        }
    }

    for (int i = 0; i < uniqueCount; i++) {
        free(freqMap[i].str);
    }
    free(freqMap);

    return result;
}