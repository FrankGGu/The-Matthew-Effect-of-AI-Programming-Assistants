#include <stdlib.h>
#include <string.h>

typedef struct {
    char* name;
    int height;
} Person;

int comparePeople(const void* a, const void* b) {
    Person* personA = (Person*)a;
    Person* personB = (Person*)b;
    return personB->height - personA->height;
}

char** sortPeople(char** names, int namesSize, int* heights, int heightsSize, int* returnSize) {
    Person* people = (Person*)malloc(namesSize * sizeof(Person));
    if (people == NULL) {
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < namesSize; i++) {
        people[i].name = names[i];
        people[i].height = heights[i];
    }

    qsort(people, namesSize, sizeof(Person), comparePeople);

    char** sortedNames = (char**)malloc(namesSize * sizeof(char*));
    if (sortedNames == NULL) {
        free(people);
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < namesSize; i++) {
        sortedNames[i] = people[i].name;
    }

    *returnSize = namesSize;

    free(people);

    return sortedNames;
}