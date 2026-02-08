#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* getEarliestDynasty(char** artifacts, int artifactsSize) {
    char* dynasties[] = {"Shang", "Zhou", "Qin", "Han", "Jin", "Tang", "Song", "Yuan", "Ming", "Qing"};
    int dynastyOrder[] = {1600, 1046, 221, 206, 265, 618, 960, 1271, 1368, 1644};
    int minYear = 2500;
    char* result = (char*)malloc(10 * sizeof(char));
    for (int i = 0; i < artifactsSize; i++) {
        char* artifact = artifacts[i];
        int year = atoi(artifact);
        for (int j = 0; j < 10; j++) {
            if (year <= dynastyOrder[j]) {
                strcpy(result, dynasties[j]);
                break;
            }
        }
    }
    return result;
}