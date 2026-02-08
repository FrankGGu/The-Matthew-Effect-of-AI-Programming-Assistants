#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* city;
    int inDegree;
    int outDegree;
} City;

int compare(const void* a, const void* b) {
    return strcmp(((City*)a)->city, ((City*)b)->city);
}

char* findPort(char** cities, int citiesSize) {
    City* cityList = (City*)malloc(citiesSize * sizeof(City));
    for (int i = 0; i < citiesSize; i++) {
        cityList[i].city = cities[i];
        cityList[i].inDegree = 0;
        cityList[i].outDegree = 0;
    }

    for (int i = 0; i < citiesSize; i++) {
        for (int j = 0; j < citiesSize; j++) {
            if (i != j && strstr(cities[j], cities[i])) {
                cityList[i].outDegree++;
                cityList[j].inDegree++;
            }
        }
    }

    qsort(cityList, citiesSize, sizeof(City), compare);

    for (int i = 0; i < citiesSize; i++) {
        if (cityList[i].inDegree == 0 && cityList[i].outDegree == citiesSize - 1) {
            char* result = (char*)malloc(strlen(cityList[i].city) + 1);
            strcpy(result, cityList[i].city);
            free(cityList);
            return result;
        }
    }

    free(cityList);
    return NULL;
}